# Fase 1 Audit Report — Root Cause (02/03)

Tanggal: 2026-09-21. Sifat: READ-ONLY (tidak ada file sumber yang diubah).
Sampel utama: `D:\Ceritas-Batch\output\matkul-02\topik-04\` (fresh, meta `2026-09-21T08:35`,
template `makalah`, mode `outline`) + pembanding `matkul-03\topik-04` (fresh, makalah)
dan `matkul-03\topik-15` (stale, IEEE, tanpa `meta.json`).

## 1. Content Pollution (Ulumul Hadis bahas PIH)

**Finding:**
- `matkul-02/topik-04/paper.md`: Kata Pengantar, Latar Belakang, Pokok Masalah,
  Pentingnya, Analisis, Kesimpulan penuh kosakata PIH: HAM, UUD 1945, rechtsstaat,
  negara hukum, hak konstitusional, hak perdata, penegakan hukum, perlindungan hukum,
  studi kasus. Contoh: "Nilai keadilan dalam hadits pun dikaitkan dengan kerangka
  UUD 1945 serta konsep negara hukum atau rechtsstaat" (Kata Pengantar);
  "Sebagaimana dikemukakan Asshiddiqie (2006)..." (Latar Belakang, tanpa `\cite`).
- `matkul-03/topik-04/paper.md` (Moderasi): Pendahuluan memakai `\cite{marzuki2018}`,
  `\cite{rahardjo2014}` + narasi rechtsstaat/HAM/UUD 1945 yang sama.
- Efek korpus: plagiarism internal 02-04 match 58% ke paper Moderasi + 1% ke dua
  paper PIH (`audit-report.md`) — semua matkul bicara bahasa yang sama.

**Root cause:**
1. `product/apps/api/services/rps-batch/generator.js:168-184` (`styleHint`) menempel
   `config.author_style.keywords` ke **setiap** prompt section. Keywords global di
   `D:/Ceritas-Batch/config.md:53-66` = 12 istilah PIH (`hak asasi manusia`, `HAM`,
   `perlindungan hukum`, `keadilan`, `UUD 1945`, `negara hukum`, `rechtsstaat`,
   `konstitusi`, `hak konstitusional`, `hak perdata`, `penegakan hukum`, `studi kasus`).
   Override `02:`/`03:` di `config.md:105-136` **tidak** mendefinisikan `author_style`
   sendiri → mewarisi PIH. Ini penyebab terbesar polusi (instruksi eksplisit
   "Utamakan kata kunci: ...").
2. `generator.js:223-241` (`buildPrompt`): `ctx` (L224) hanya berisi
   `title/week/cpmk` — **tidak ada** `config.mata_kuliah`/`dosen`/domain. System prompt
   (L246-249) generik ("asisten penulisan akademik"). LLM tidak diberi tahu ia
   menulis untuk Ulumul Hadis/Moderasi → mengisi dari asosiasi dominan (hukum).
3. Tabrakan key `SECTION_PROMPTS`: `analisis` didefinisikan dua kali (L81 generik,
   L93-94 PIH narrative dengan kunci marzuki dkk) — di JS object literal, definisi
   terakhir menang → section `analisis` matkul-02 dapat instruksi PIH + `\cite` PIH.
   `pendahuluan`/`pembahasan` (L89-92) memang PIH-spesifik (contoh "Negara hukum
   melindungi HAM", sub-bagian Pengertian/Klasifikasi/Relasi/Perlindungan,
   key marzuki2018 dkk) dan dipakai ulang mentah oleh matkul-03 yang sections-nya
   (`config.md:132-136`) memakai key yang sama persis.
4. Laten: `fallbackAbstract` (L288-312) + `fallbackKeywords` (L314-327) hardcode PIH
   ("Pengantar Ilmu Hukum", "UUD 1945", base keywords hukum dan hak/negara hukum...).

**Fix needed:**
- Batasi keywords PIH hanya untuk matkul-01 (atau tambah `author_style` per-matkul
  02/03 berisi istilah hadis/moderasi); pertimbangkan keywords sebagai daftar
  "jangan paksa di luar domain".
- Suntik `mata_kuliah` (+ dosen, domain/topik RPS) ke `ctx`/system prompt; tolak
  prompt tanpa konteks matkul.
- Pecah key prompt yang bertabrakan (`analisis` generik vs narrative-PIH;
  `pendahuluan`/`pembahasan` PIH hanya untuk mode narrative matkul-01).
- Netralkan fallback abstrak/keywords (tanpa domain hardcode).

## 2. Section Auto-Numbered (1, 2, 3)

**Finding:** `matkul-02/topik-04/paper.tex:48,63,79,88,94,...` memakai
`\section{Pendahuluan — Latar Belakang}`, `\section{...Pokok Masalah}`, dst.
Di kelas `article` ini ter-render sebagai "1, 2, 3..." di PDF, bukan BAB I/II/III
ala makalah UIN.

**Root cause:** `product/apps/api/services/rps-batch/templates/makalah-paper.js:75`
me-render semua chapter sebagai `\section{...}` (numbered); hanya Kata Pengantar
yang `\section*` (L74). Tidak ada pemetaan BAB romawi / `\section*` + label manual.

**Fix needed:** Putuskan konvensi (rekomendasi: `\section*{BAB I — ...}` + mapping
romawi per urutan chapter, Kata Pengantar/penutup tetap unnumbered), terapkan di
`renderMakalahPaper`.

## 3. Duplikasi Heading

**Finding:** `paper.tex:48-49`: `\section{Pendahuluan — Latar Belakang}` langsung
diikuti `\textbf{Pendahuluan — Latar Belakang}` (baris pertama body). Pola sama di
chapter lain. Sumbernya terlihat di `paper.md`: body LLM diawali baris bold judul.

**Root cause:** `generator.js:602-605` membungkus tiap section sebagai
`## ${heading}` + body apa adanya (body LLM sering mengulang judul sebagai bold).
`latex.js:30-47` (`splitChaptersMakalah`) split pada `## ` tapi menyimpan body
verbatim; `makalah-paper.js:69-78` menambah `\section` lagi tanpa strip.
Catatan: `services/latex.js:chaptersToLatex` **punya** logika dedup H1-vs-judul,
tetapi jalur makalah tidak memakainya.

**Fix needed:** Strip baris pertama body bila sama dengan judul chapter (bold,
heading `#`, atau teks polos, case-insensitive) di `splitChaptersMakalah` atau
`renderMakalahPaper`; instruksikan LLM "jangan mengulang judul di body".

## 4. HTML `<td>` Literal

**Finding:** TIDAK ditemukan di output saat ini — pencarian `<td|<table|<tr|rowspan`
dan pipe-table `|...|` pada seluruh `paper.md`/`paper.tex` matkul-02 + matkul-03
menghasilkan **nol hit**. Kemungkinan berasal dari run lama / topik spesifik
(LLM menulis tabel perbandingan/klasifikasi) yang sudah ter-overwrite, atau dari
render PDF yang dilaporkan user.

**Root cause (laten, tetap valid):** `product/apps/api/services/latex.js:22-...`
(`mdToLatex`) tidak mengenal tabel maupun HTML: `inline()` hanya escape `&%$#_`
dan membiarkan `<...>` lolos verbatim; tidak ada konversi pipe-table ke
`tabular`. Setiap HTML/tabel dari LLM akan mendarat literal di PDF.

**Fix needed:** Tambah sanitasi di `mdToLatex`: strip/escape tag HTML
(`<table>`, `<td>`, `<tr>`, ...), konversi pipe-table ke `tabular`/`longtable`
atau daftar polos; tambah validator "no raw HTML".

## 5. Referensi Inline (5.0.7)

**Finding:** `matkul-02/topik-04/paper.tex:125`: `\subsubsection{Referensi}` berisi 3
baris APA mentah (Al-Bukhari, Asshiddiqie, Hallaq — terakhir terpotong
"Hallaq, Wael B. *A History..."). Karena ia subsubsection ke-7 di dalam `\section`
ke-5 (Pembahasan), LaTeX me-render-nya sebagai **"5.0.7 Referensi"** — persis yang
dilaporkan. `paper.md` memastikan sumbernya: blok `### Referensi` di dalam body
`pembahasan_utama`.

**Root cause:** LLM menulis `### Referensi` di dalam body pembahasan.
`splitChaptersMakalah` (`latex.js:36`) hanya split pada `## ` sehingga `###`
tetap di body; `mdToLatex` (`services/latex.js:50-52`) memetakan `###` →
`\subsubsection`. Tidak ada filter "referensi-like" untuk level `###`.
(Kasus `matkul-03/topik-15/paper.tex:70` `\section{Referensi}` adalah artefak
berbeda: file stale bertemplate IEEE tanpa `meta.json` — lihat catatan di bawah.)

**Fix needed:** Drop/strip subheading body yang cocok
`referensi|daftar pustaka|references|bibliography` (level `###`/`####`) beserta
daftar mentahnya (pustaka hanya via BibTeX); tambah larangan "jangan tulis
referensi di body" pada prompt `pembahasan_utama`.

## 6. Sitasi `[?]` + Pustaka Kosong

**Finding:**
- Body memakai `\cite{marzuki2018}` dan `\cite{rahardjo2014}` (Analisis 02-04;
  Pendahuluan 03-04), tetapi `refs.bib` berisi 6 key Crossref topikal
  (`rahman1974rahman`, `yurnalis2023kedudukan`, `manggala2024upaya`,
  `fail2021kedudukan`, `sugiri2023pemahaman`, `hadija2021filosofi`) — **nol irisan**.
- `paper.blg`: "didn't find a database entry for marzuki2018/rahardjo2014",
  "You've used 0 entries". `paper.bbl` = `thebibliography` kosong.
  `paper.log`: "Citation marzuki2018/rahardjo2014 undefined" → `[?]` di PDF.
- Body juga memakai sitasi author-year polos `(Asshiddiqie, 2006)`, `(al-Tahhan 2004)`,
  `MD (2011)` tanpa `\cite` → tidak pernah ter-resolve.
- Chapter Daftar Pustaka di-exclude (`MAKALAH_EXCLUDED`, `makalah-paper.js:21`;
  filter `latex.js:45`), sehingga satu-satunya pustaka adalah
  `\bibliography{refs}` yang kosong → DAFTAR PUSTAKA kosong.

**Root cause:**
1. Prompt `analisis` (dan `pendahuluan`/`pembahasan` untuk 03) menyuntik key
   `marzuki2018` dkk (`generator.js:89-94`) sementara `CITE_RULE` (L218-221) hanya
   ditempel untuk mode `narrative` — 02 ber-mode `outline`, jadi tidak ada proteksi
   tetapi LLM tetap meng-emit `\cite` dari hint.
2. `refs.bib` berasal dari pencarian Crossref topikal yang independen dari key
   `\cite` di body — tidak ada rekonsiliasi key.
3. Desain pustaka makalah hanya mengandalkan BibTeX; bila tidak ada `\cite` yang
   cocok, pustaka = kosong (tidak ada fallback render APA).

**Fix needed:** Satukan kontrak sitasi: umpankan daftar key bib yang tersedia ke
prompt; validasi pra-compile bahwa setiap `\cite{key}` ada di bib (gagalkan/
perbaiki bila tidak); konversi author-year polos ke `\cite` atau hapus;
pertimbangkan fallback render daftar APA bila bib kosong.

## 7. Validation Layer Gagal Deteksi

**Finding:** `RULES.makalah` (`validateOutput.js:12-16`) hanya 3 cek kelas dokumen
(`article class`, `NO IEEEtran`, `NO Index Terms`). Uji langsung pada tex 02-04
yang rusak: **valid:true (3/3 passed)** — semua bug di atas lolos. Validator
bersifat warn-only dari `latex.js`, jadi tidak ada yang menahan output rusak.

**Fix needed:** Tambah cek makalah: (a) setiap `\cite{key}` ada di `refs.bib`;
(b) tidak ada `\subsubsection{Referensi|Daftar Pustaka|References}`;
(c) tidak ada duplikasi `\section{X}` + `\textbf{X}` berurutan;
(d) tidak ada tag HTML mentah (`<[a-z]+[^>]*>`) dan tidak ada pipe-table mentah;
(e) section memakai konvensi BAB (atau `\section*`); (f) `.bbl`/bibliography
tidak kosong. Pertimbangkan gagalkan (bukan warn-only) untuk pelanggaran sitasi/
pustaka.

## Catatan tambahan — artefak stale matkul-03/topik-15

`matkul-03/topik-15/` berisi `paper.tex` bertemplate **IEEEtran** (`\section{Outline}`,
`\section{Latar Belakang}`, `\section{Referensi}` mentah, `\textit\{...}` rusak
dengan escape ganda) dan **tanpa** `meta.json`/`section-meta.json`. Isi `paper.md`
(`## Outline/Latar Belakang/...`) = 5 section default lama, bukan 4 section
`config.md:132-136` saat ini. Ini output pipeline versi lama yang belum di-regen —
ikutkan dalam regen Fase 3 / bersihkan.

## Rekomendasi Fix per Fase

| Fase | File | Aksi | Estimasi |
|---|---|---|---|
| 2a | `generator.js` + `D:/Ceritas-Batch/config.md` | Scoping `author_style` per-matkul; suntik `mata_kuliah`/dosen ke prompt+system; pecah key `analisis/pendahuluan/pembahasan` PIH vs generik; netralkan fallback abstrak/keywords | 15 menit |
| 2b | `makalah-paper.js`, `latex.js` (`splitChaptersMakalah`), `services/latex.js` (`mdToLatex`) | BAB romawi + `\section*`; strip judul-duplikat di body; strip subheading referensi inline; sanitasi HTML + konversi pipe-table | 25 menit |
| 2c | `validateOutput.js` (+ wiring di `latex.js`) | Tambah cek: cite⊆bib, no-Referensi-inline, no-dup-heading, no-HTML, konvensi BAB, bib non-kosong; pertimbangkan hard-fail sitasi | 10 menit |
| 3 | (regen) | Regen matkul-02 + matkul-03 (termasuk topik-15 stale), verifikasi PDF: BAB, pustaka terisi, nol `[?]`, nol HTML literal | 15 menit |
