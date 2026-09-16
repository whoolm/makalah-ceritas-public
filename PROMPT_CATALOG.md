# PROMPT CATALOG — Semua Prompt ke AI

> Katalog seluruh prompt yang dipakai proyek Makalah Ceritas.
> Setiap prompt: self-contained (copy-paste langsung), tool target, kondisi trigger,
> output yang diharapkan. Direktori kerja: `C:\Users\USER\Documents\Default Project`.
> Aturan proyek: data tak ada = `TIDAK_TERSEDIA`; konflik dicatat dua versi.

---

## 1. Prompt Ekstraksi Chat

### 1.1 Bypass WAF + Ekstrak 6 URL

- **Tool target:** OpenCode (eksekutor) + JSON API share-chat.
- **Trigger:** Memulai proyek baru dari percakapan AI (sumber pengetahuan tersebar di chat).
- **Latar (fakta proyek):** Fetch HTML mentah 6 URL DeepSeek terhalang WAF (`raw/errors.log`,
  `raw/C1–C6.html` hanya stub di-exclude dari git); data diambil via JSON API ke
  `raw/C1–C6.json`, lalu transkrip terstruktur `extracted/C1–C6.json`
  (skema id/url/title/messages/metadata), lalu konsolidasi `memory/chat_memory.json` + `.md`.
  Total 376 pesan (C1=212, C2=12, C3=2, C4=2, C5=10, C6=138).

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Tujuan: ekstrak N share-URL chat menjadi memori terstruktur (raw → extracted → memory).

1. Untuk tiap URL share chat: JANGAN fetch HTML (terhalang WAF — hanya menghasilkan stub).
   Ambil via JSON API endpoint share tersebut; simpan respons mentah ke raw/C<n>.json.
   Catat sukses/gagal per URL di raw/errors.log (tandai NOTE WAF bila relevan).
2. Dari tiap raw/C<n>.json, ekstrak field data.biz_data.messages[].content menjadi
   extracted/C<n>.json dengan skema: id, url, title, messages[], metadata.
   Jangkar sitasi memakai message_id mentah (format C<n>-msg<message_id>) — JANGAN
   memakai nomor urut tampilan (meleset pada cabang pruned).
3. Konsolidasikan ke memory/chat_memory.json + memory/chat_memory.md (tabel per chat).
4. Hitung keyword HANYA level pesan (satu pesan = 1 hit per keyword, case-insensitive);
   JANGAN hitung level baris Select-String (menggandakan varian case).
5. Laporkan: jumlah pesan per chat, total pesan, file yang ditulis.
   Data tak ada = TIDAK_TERSEDIA. Konflik antar-pesan dicatat dua versi.
```

- **Output diharapkan:** `raw/` + `extracted/` + `memory/` lengkap; angka pesan per chat;
  `errors.log` 6/6 sukses (atau daftar gagal jujur).

---

## 2. Prompt Research Pustaka

### 2.1 Multi-Tool Query (4 sub-tema)

- **Tool target:** Perplexity (awal) → LeapSpace (4 prompt) → Consensus → Elicit →
  Semantic Scholar → Research Rabbit → Connected Papers → Scite → SciSpace → Gemini Deep Research.
- **Trigger:** Fase research topik baru (lihat `RESEARCH_PUSTAKA_WORKFLOW.md`,
  `WORKFLOW_RESEARCH_GENERIK.md`, `makalah-hadis/QUERY_LIBRARY.md`).
- **Batasan fakta:** LeapSpace maks 500 karakter/prompt (C1-msg41) — strategi: P1&P4 Deep
  Research, P2&P3 Copilot (C1-msg49). Consensus BUKAN meta-analisis formal (maks 20 artikel).
  Kitab primer Arab TIDAK ada di Perplexity/Crossref — cari di sunnah.com / shamela.ws /
  archive.org (`makalah-hadis/WORKFLOW_HADIS.md`, `KITAB_PRIMER.md`).

```markdown
Topik: <<TOPIK>>. Sub-tema: (1) <<SUB-TEMA-1>> (2) <<SUB-TEMA-2>> (3) <<SUB-TEMA-3>>
(4) <<SUB-TEMA-4>> (contoh teruji: periodisasi, penghimpunan, pemalsuan, era digital).

Langkah A — Perplexity Academic (per sub-tema, copy-paste):
"Cari 15 artikel ilmiah terbaru (2015-2026) tentang **<<SUB-TEMA>>** — <<FOKUS-3-4-POIN>>.
Berikan DOI, judul, penulis, ringkasan 1 paragraf per artikel."
Output: tabel No | Penulis | Judul | Jurnal/Sumber | Tahun | DOI | Sub-tema | Status.

Langkah B — LeapSpace 4 prompt (≤500 karakter tiap prompt, JANGAN lebih):
- P1 (Deep Research): "<<SUB-TEMA-1>>. Analisis: (1) ... (2) ... (3) ... Sertakan
  sumber dari jurnal Scopus/SINTA 1-2."
- P2 (Copilot): "Bandingkan <<A>> dengan <<B>> dalam hal: ... Sertakan referensi akademik."
- P3 (Copilot): "Bandingkan <<C>> dengan <<D>>. Apa titik temu & perbedaan? Sertakan contoh."
- P4 (Deep Research): "<<SUB-TEMA-4>>: tantangan & peluang. Analisis: (1) ... (5) ...
  Sumber akademik."
Output: 4 laporan + ringkasan 200 kata per laporan.

Langkah C — Consensus (satu pertanyaan Ya/Tidak per sub-tema, contoh teruji):
"Apakah <<KLAIM_YA_TIDAK>>?" (cth: "...pembukuan hadis resmi dimulai pada masa
Umar bin Abdul Aziz?"; "...larangan penulisan hadis bersifat mutlak atau kontekstual?")
Output: Consensus Meter (Yes/No/Possibly %) + 20 artikel + Study Snapshots.
INGAT: ini indikasi cepat, BUKAN meta-analisis.

Langkah D — Elicit Agen (EN, contoh teruji C1-msg68):
"<<RESEARCH-QUESTION-EN>>. Extract: (1) methodology, (2) sample/population,
(3) main findings, (4) theoretical framework. Follow PRISMA 2020."
Output: tabel ekstraksi + export CSV (+ PRISMA flow bila systematic review).

Langkah E — Pemetaan sitasi (seed paper: <<SEED-1>>, <<SEED-2>>; cth hadis: Ajaj al-Khatib,
M.M. Azami, Subhi as-Salih, Ibn al-Jauzi — catat: primer klasik kemungkinan TIDAK
terindex; cari manual):
Semantic Scholar (TL;DR + Ask-this-paper) → Research Rabbit (visual graph) →
Connected Papers (Prior/Derivative) → Scite (supporting/contrasting/mentioning).

Langkah F — Gemini Deep Research (1 prompt gabungan, contoh teruji C1-msg94):
"Lakukan deep research komprehensif tentang <<TOPIK>> mencakup <<N>> dimensi: [list].
Syarat: minimal 30 sumber dari jurnal Scopus dan SINTA 1-2 (<<TAHUN-AWAL>>-<<TAHUN-AKHIR>>),
matriks perbandingan + celah riset."
Output: laporan multi-dimensi + daftar "Karya yang Dikutip".
Jika server penuh: TUNDA Gemini, kerjakan tool lain dulu (C1-msg63).
```

- **Output diharapkan:** 15 ref/sub-tema + 4 laporan LeapSpace + gauge Consensus +
  tabel Elicit + graf sitasi + laporan deep research; kriteria inklusi eksplisit
  (tahun, Scopus/SINTA 1-2); angka yang inkonsisten dicatat sebagai RENTANG.

### 2.2 Verifikasi DOI Otomatis

- **Tool target:** OpenCode (skrip + Crossref API) + SciSpace Citation Generator.
- **Trigger:** Setelah korpus terkumpul; sebelum drafting dan sebelum konversi footnote.
- **Fakta proyek:** 7 DOI inti terverifikasi Crossref (Latif 2018, Madung 2016, Duha 2022,
  Kim 2024, Pristiwiyanto 2021, MadungMere 2021, UlumHamida 2018); 33 entri `@misc`
  minimal-DOI wajib dilengkapi via Citation Generator; cache contoh:
  `makalah-hadis/draft/crossref_cache.json`; status: `makalah-hadis/VERIFIKASI_DOI.md`.

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Baca: makalah-hadis/VERIFIKASI_DOI.md, makalah-hadis/bibliography_map.md.

1. Untuk tiap DOI di korpus (atau 5 sampel acak bila korpus > 50): query Crossref API,
   cocokkan judul + penulis + tahun + jurnal. Cache respons ke crossref_cache.json.
2. Tandai per entri: ✅ cocok penuh / ⚠️ metadata kurang (tulis field yang hilang,
   JANGAN dikarang) / ❌ DOI mati (usulkan pengganti dari SciSpace Citation Generator).
3. Kitab/buku klasik TANPA DOI (kitab Arab, al-Maudhu'at, dll.): JANGAN dipaksa ke Crossref —
   catat sumber manual (shamela.ws / archive.org) + status VERIFIKASI_MANUAL.
4. Syarat lolos ke drafting: 0 DOI mati tanpa pengganti; entri tanpa halaman/tahun
   TERTANDA eksplisit (contoh nyata: 4 entry tanpa halaman — Abdulrahman 2024, Mosa 2025,
   Rozikin 2026, Shaaban 2026 — perlu VERIFIKASI_MANUAL sebelum konversi footnote).
5. Laporkan tabel: DOI | status | masalah | tindak lanjut.
```

- **Output diharapkan:** cache Crossref + tabel status per DOI + daftar VERIFIKASI_MANUAL;
  0 DOI mati tanpa pengganti.

---

## 3. Prompt Drafting

### 3.1 Generate Bab I–III

- **Tool target:** Claude (penulis) + DeepSeek (sintesis operasional).
- **Trigger:** Korpus terverifikasi (§2.2 lolos); mulai penulisan naskah baru.
- **Fakta proyek:** Struktur teruji `makalah-hadis/draft/`: `DRAFT_SKELETON.md` →
  `BAB_I_PENDAHULUAN.md`, `BAB_II_A/B/C.md` (periodisasi/penghimpunan/pemalsuan),
  `BAB_III_PENUTUP.md`, `KATA_PENGANTAR.md`, `DAFTAR_PUSTAKA.md`, input fase-C
  `FASE_C_CLAUDE_INPUT.md`, target `MAKALAH_FINAL.md` (11.462 kata; 35 rujukan utama).

```markdown
Peran: kamu (Claude) penulis/revisor; DeepSeek orkestrator operasional
("ingat kamu ini deepseek sebagai operasional" — sintesis, BUKAN riset sendiri).
Topik: <<TOPIK>>. Korpus: <<DAFTAR-DOI-TERVERIFIKASI>> (+ kitab primer manual bila ada).

1. Tulis DRAFT_SKELETON.md dulu: rumusan masalah (3), outline BAB I (latar, rumusan,
   tujuan, manfaat teoretis/praktis, metode, state of the art), BAB II (3 sub-bab
   sesuai <<SUB-TEMA-1..3>>), BAB III (5 kesimpulan bernomor + 5 saran \item).
   BERHENTI — tunggu persetujuan skeleton sebelum menulis penuh.
2. Setelah disetujui, tulis tiap bab sebagai file terpisah (BAB_I_*.md, BAB_II_A_*.md, ...).
   Setiap klaim faktual WAJIB menunjuk sumber korpus (format sementara: (Nama, Tahun) —
   konversi footnote dikerjakan Fase Template, §5.1).
3. Revisi ala Claude (checklist): hapus duplikasi; angka konsisten (abstrak ~230 kata,
   keywords 5–7 bila jalur IEEE); kunci sitasi unik (pelajaran: bengbeng → gumilanghudaefi);
   entri tanpa year/metadata tulis % TODO(editor), JANGAN dikarang.
4. Verifikasi terprogram: cross-check \cite ↔ .bib (target 100%), hitung kata abstrak,
   cek duplikasi. Laporkan: file ditulis, sisa TODO, status verifikasi.
```

- **Output diharapkan:** skeleton disetujui + file bab terpisah + daftar TODO eksplisit;
  0 klaim tanpa sumber.

### 3.2 Parafrase Anti-Plagiarisme

- **Tool target:** Claude (parafrase) + OpenCode (deteksi overlap).
- **Trigger:** Draf mentah selesai; sebelum konversi ke `.tex`.
- **Fakta proyek:** Varian teruji: `*.md` (mentah) → `*_POLISHED.md` (dipoles, file POLISHED
  TIDAK dimodifikasi saat konversi) → `*_PARAFRASE.md`; overlap dilacak
  (`makalah-hadis/draft/overlap_bab_iii.txt`, `FIX_REPORT.md`).

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Input: makalah-hadis/draft/<<BAB>>.md (atau BAB baru setara). JANGAN ubah file input;
tulis output ke <<BAB>>_PARAFRASE.md (dan _POLISHED bila perlu tahap poles).

1. Parafrase per paragraf: ubah struktur kalimat + diksi akademik, PERTAHANKAN makna,
   istilah teknis Arab (\textit), angka/tahun/nama, dan penanda sumber (Nama, Tahun).
2. JANGAN gabungkan dua klaim dari sumber berbeda dalam satu kalimat tanpa dua penanda.
3. Setelah parafrase, hitung overlap vs file sumber (lapor dalam gaya overlap_bab_iii.txt:
   pasangan kalimat + % kemiripan) dan tulis FIX_REPORT.md (masalah → perbaikan).
4. Kriteria selesai: tiap paragraf terparafrase, 0 klaim kehilangan sumber,
   file mentah/POLISHED utuh tidak tersentuh. Laporkan sisa overlap > ambang + usulannya.
```

- **Output diharapkan:** `*_PARAFRASE.md` + laporan overlap + `FIX_REPORT.md`.

---

## 4. Prompt Template Build

### 4.1 Build Template IEEE

- **Tool target:** OpenCode. **Trigger:** Paper baru jalur artikel jurnal.
- **Acuan:** `template-ieee/README_TEMPLATE.md`, `template-ieee/template_ieee.tex`,
  `PROMPTS.md` Prompt 1, `WORKFLOW.md` §3.

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Baca dulu: CONTEXT.md, template-ieee/README_TEMPLATE.md, template-ieee/template_ieee.tex.

Buat paper baru <<NAMA-PAPER>> (kalau belum ada nama, tanya dulu):
1. Copy template-ieee/template_ieee.tex → <<NAMA-PAPER>>.tex dan
   template-ieee/referensi_template.bib → referensi_<<NAMA-PAPER>>.bib
   (folder paper baru, atau root bila saya tidak minta folder baru).
2. Ubah \bibliography{referensi_template} → \bibliography{referensi_<<NAMA-PAPER>>}.
3. List placeholder (grep -n '<<'); ganti SEMUA yang datanya sudah saya beri; sisanya
   TIDAK_TERSEDIA (jangan dikarang). Format HYPHEN (<<NIM-1>>, bukan <<NIM_1>>).
4. Author block: panggilan+NIM vertikal, afiliasi 1×, dosen di halaman judul,
   footer tugas tengah. Cover: \IfFileExists + \newgeometry{margin=0} +
   \setcounter{page}{1} seperti template.
5. Aturan IEEE: label Abstract (wajib \addto\captionsindonesian), Abstract—/Index Terms—
   bold+em-dash, asing \textit, sitasi \cite, tabel table*, tanpa \linenumbers,
   tanpa bold body.
6. Compile: .\build.ps1 (pdflatex → bibtex → pdflatex ×2). Target: 0 error, 0 undefined.
7. Laporkan: file dibuat, sisa TIDAK_TERSEDIA, status compile. JANGAN commit/tag dulu.
```

- **Output diharapkan:** `.tex`+`.bib` terisi, PDF terkompilasi 0 error, daftar sisa placeholder.

### 4.2 Build Template Elsevier

- **Tool target:** OpenCode. **Trigger:** Butuh varian jurnal Elsevier (`elsarticle`).
- **Acuan:** `PROMPTS.md` Prompt 8; hasil teruji: `template-elsevier/` (tag `elsevier-v1.1`).

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Baca: CONTEXT.md, template-ieee/template_ieee.tex, template-ieee/build.ps1.

Konversi template-ieee/ → template-elsevier/ (repo terpisah, TANPA .git lama):
1. Copy struktur KECUALI .git/ (.tex, .bib, build/clean/Makefile/.gitignore/README/cover).
2. \documentclass[journal]{IEEEtran} → \documentclass[preprint,12pt]{elsarticle};
   hapus paket khusus IEEE yang konflik (cite, stfloats bila bermasalah — uji via compile).
3. \bibliographystyle{IEEEtran} → elsarticle-num; sesuaikan \bibliography{...}.
4. Author block: \IEEEauthorblockN/A → \author/\address (+ \ead email; NIM via
   \fnref/\tnoteref bila diminta).
5. IEEEkeywords → \begin{keyword}...\end{keyword}; \markboth → frontmatter
   (\title+\author/\address+\begin{abstract}+\begin{keyword}).
   Label abstrak ikut keputusan gaya yang berlaku (K-06: ala Elsevier).
6. Pertahankan cover (titlepage + \newgeometry + \IfFileExists + \restoregeometry +
   \setcounter{page}{1}) dan setara \IEEEPARstart (drop cap manual/lettrine).
7. Sesuaikan build/clean/Makefile/.gitignore/README; placeholder HYPHEN tetap utuh.
8. Compile sampai 0 error + 0 undefined. Git init terpisah, tag elsevier-v1.0.
   JANGAN commit ke parent sebelum saya setuju; laporkan diff vs template-ieee.
```

- **Output diharapkan:** repo `template-elsevier/` terkompilasi + tag; diff struktur vs IEEE.

### 4.3 Build Template Makalah UIN

- **Tool target:** OpenCode. **Trigger:** Makalah kuliah standar kampus (tugas, jilid, softfile).
- **Acuan:** `template-makalah/README_TEMPLATE.md`; hasil teruji: `template-makalah/`
  (build-ps1/sh/Makefile, `build-jilid.ps1`, `build-softfile.ps1`, `build-all.ps1`).

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Baca: CONTEXT.md, template-makalah/README_TEMPLATE.md.

1. Siapkan/salin struktur: template-makalah.tex (main), halaman-judul.tex, kp.tex (kata
   pengantar), bab1.tex, bab2.tex, bab3.tex, pustaka.tex, pustaka.bib (opsional),
   cover.png, logo_walisongo.png.
2. Spesifikasi WAJIB: article 12pt A4 1 kolom; Times 12pt; spasi 1.5; margin
   kiri 4 / atas 4 / kanan 3 / bawah 3 cm; babel Indonesia.
3. Isi dari draf: *_POLISHED.md → kp/bab1-3.tex; DAFTAR_PUSTAKA.md → pustaka.tex
   (enumerate hanging indent). File POLISHED TIDAK dimodifikasi.
4. Heading: \section*/\subsection*/\subsubsection* (+ \addcontentsline untuk BAB);
   Arab/transliterasi \textit (atau \arabicterm); sitasi teks (Nama, Tahun) + footnote
   skripsi-grade (§5.1); cover full-page + fallback judul teks.
5. Compile: .\build.ps1 (pdflatex ×2 — cukup, tanpa BibTeX). Varian: build-jilid.ps1 /
   build-softfile.ps1 bila diminta.
6. Target: 0 error; TOC terisi (pass ke-2); cover tampil. Laporkan status + sisa TODO.
   JANGAN commit dulu.
```

- **Output diharapkan:** PDF makalah (+ varian jilid/softfile bila diminta), 0 error.

---

## 5. Prompt Footnote Skripsi-Grade

### 5.1 Konversi Footnote (Hybrid)

- **Tool target:** OpenCode (konversi) + manusia (VERIFIKASI_MANUAL).
- **Trigger:** Draf `.md` berpenanda `(Nama, Tahun)` siap menjadi `.tex` jalur Makalah Kuliah.
- **Fakta proyek:** Peta key→metadata: `makalah-hadis/bibliography_map.json` (+ `.md`);
  format hybrid teruji di `template-makalah/bab1-3.tex`: kutipan PERTAMA penuh
  (`\footnote{A. Musadad, "Articulating ...," \textit{Jurnal ...}, vol. 27, no. 1,
  hlm. 351--373, 2026; ...}`), kutipan BERIKUTNYA singkat (`\footnote{Musadad,
  "Articulating the Prophetic Authority."; ...}`); 4 entry tanpa halaman butuh
  VERIFIKASI_MANUAL sebelum konversi (`bibliography_map.md`).

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Baca: makalah-hadis/bibliography_map.md, makalah-hadis/bibliography_map.json,
template-makalah/bab1.tex (contoh format hybrid, 5 footnote pertama sebagai pola).

1. Untuk tiap penanda (Nama, Tahun) di <<BAB>>.md: cari key di bibliography_map.json.
   Key TIDAK KETEMU → tandai [[FOOTNOTE-MISSING: Nama, Tahun]] dan lanjut (JANGAN karang).
2. Kutipan PERTAMA tiap karya → footnote PENUH:
   \footnote{<<Inisial. Nama>>, "<<Judul>>," \textit{<<Jurnal>>}, vol. <<V>>, no. <<N>>,
   hlm. <<P--P>>, <<Tahun>>.}
   Kutipan BERIKUTNYA → footnote SINGKAT: \footnote{<<Nama-pendek>>, "<<Judul-pendek>>.".}
   Gabung multi-sumber dalam SATU footnote dengan pemisah "; " (lihat pola bab1.tex).
3. Judul buku/kitab Arab italic (\textit); "hlm." untuk halaman (bukan "pp.");
   entri tanpa halaman/tahun → konversi TETAP jalan dengan penanda % TODO(editor),
   masuk daftar VERIFIKASI_MANUAL.
4. Verifikasi: tiap footnote menunjuk karya di bibliography_map; 0 key fiktif;
   compile .\build.ps1 0 error. Laporkan: jumlah footnote penuh/singkat,
   daftar MISSING + VERIFIKASI_MANUAL.
```

- **Output diharapkan:** `.tex` ber-footnote hybrid + daftar MISSING/MANUAL; 0 key fiktif.

---

## 6. Prompt Formatting

### 6.1 Fix Halaman Judul

- **Tool target:** OpenCode. **Trigger:** Halaman judul ditolak/tabrakan/duplikasi.
- **Fakta proyek:** `template-makalah/halaman-judul.tex` (+ riwayat `.bak6/.bak7/.bak9`,
  `.pre-fix3` = bukti iterasi); keputusan mengikat K-02 (panggilan+NIM vertikal),
  K-03 (NIM samping nama), K-04 (dosen di halaman judul).

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Baca: CONTEXT.md (§3 Aturan Wajib), template-makalah/halaman-judul.tex,
DECISIONS.md (K-02, K-03, K-04).

Perbaiki halaman judul sesuai: <<DESKRIPSI-MASALAH>> (default: samakan dengan pola
terakhir yang disetujui).
Aturan: (1) ubah MINIMAL, format lain untouched; (2) nama panggilan+NIM vertikal
(satu penulis per baris), NIM di samping nama, dosen pembimbing di halaman judul;
(3) tanpa duplikasi afiliasi; tanpa tabrakan footer/header; (4) compile .\build.ps1,
target 0 error; (5) laporkan diff + status. JANGAN commit sebelum saya setuju.
```

- **Output diharapkan:** halaman judul rapi + diff + status compile.

### 6.2 Fix TTD Kata Pengantar

- **Tool target:** OpenCode. **Trigger:** Blok tanda tangan kata pengantar salah posisi/format.
- **Fakta proyek:** `template-makalah/kp.tex` (+ riwayat `.bak9/.bak10/.bak11` = bukti iterasi);
  sumber isi: `makalah-hadis/draft/KATA_PENGANTAR.md`.

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Baca: template-makalah/kp.tex (blok \begin{flushright} TTD di akhir).

Perbaiki blok TTD kata pengantar: <<KOTA>>, <<TANGGAL>>, <<NAMA-PENULIS>>, <<NIM>>
(data tak ada = TIDAK_TERSEDIA, jangan karang).
Aturan: (1) format: kota, tanggal di kanan; nama terang + NIM di bawah ruang TTD;
(2) isi teks pengantar dari KATA_PENGANTAR.md — JANGAN ubah redaksi selain blok TTD;
(3) compile .\build.ps1 0 error; (4) laporkan diff. JANGAN commit sebelum saya setuju.
```

- **Output diharapkan:** blok TTD benar posisi/format + diff + status compile.

---

## 7. Prompt Finalisasi

### 7.1 Commit + Tag + Push

- **Tool target:** OpenCode (siapkan) + manusia (setujui) + git.
- **Trigger:** PDF final terverifikasi; siap rilis.
- **Acuan:** `PROMPTS.md` Prompt 6, `WORKFLOW.md` §6 (konvensi `feat:/fix:/docs:/perf:/chore:`,
  tag `paper-v*`; JANGAN geser `v1.0-prd`/`template-v2.0`), `CONTRIBUTING.md`.

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Baca: CONTEXT.md, WORKFLOW.md §6.

Siapkan commit untuk: <<DAFTAR-FILE-ATAU-PERUBAHAN>>.
1. git status + git diff --stat. Hanya file yang saya maksud yang berubah.
   Artefak (*.aux/.log/.bbl/.blg/.out/.spl/.toc) dan *.bak JANGAN ikut
   (hapus .bak dulu; artefak hanya bila saya minta eksplisit).
2. Hasil optimasi PDF tanpa keputusan saya = BERHENTI (opsi: (a) COMMIT hapus .bak,
   (b) ROLLBACK kembalikan .bak, (c) TERIMA+S5). S5 DILARANG tanpa izin eksplisit.
3. Usulkan pesan (feat:/fix:/docs:/perf:/chore:) + tag bila rilis (paper-v1.0 untuk paper;
   JANGAN geser v1.0-prd/template-v2.0/decisions-v1.0).
4. Versi lama yang digantikan → pindahkan ke arsip/ (jangan edit isi arsip).
5. Catat rencana di CHANGELOG.md (tanggal UTC, file, alasan, Indonesia).
6. Tampilkan perintah sebelum eksekusi; eksekusi (commit → tag → push → push --tags)
   HANYA setelah saya setuju.
```

- **Output diharapkan:** commit hash + tag ter-push; CHANGELOG tercatat; working tree clean.

---

## 8. Prompt Reusable untuk Makalah Baru

### 8.1 Tulis Makalah Baru dari Nol (Universal)

- **Tool target:** OpenCode + seluruh AI riset (§2.1) + Claude (drafting).
- **Trigger:** Topik makalah baru apa pun (generalisasi `WORKFLOW_RESEARCH_GENERIK.md`
  + adaptasi `makalah-hadis/WORKFLOW_HADIS.md`).
- **Peta pemakaian:** ganti `{{PLACEHOLDER}}`, jalankan 9 langkah berurutan, isi checklist.

```markdown
Direktori: C:\Users\USER\Documents\Default Project
Baca: CONTEXT.md, WORKFLOW_RESEARCH_GENERIK.md, template target
(template-ieee/README_TEMPLATE.md untuk jurnal; template-makalah/README_TEMPLATE.md
untuk tugas kuliah).

Proyek baru: {{TOPIK}} | Sub-tema: {{SUB-TEMA-1..4}} | Jalur: {{IEEE / MAKALAH}} |
Tahun: {{TAHUN-AWAL}}-{{TAHUN-AKHIR}} | Seed: {{SEED_PAPER}} | Kitab primer: {{SHAMELA-LINK?/TIDAK-ADA}}.

Fase 1 EKSTRAKSI (bila ada sumber chat): jalankan Prompt §1.1.
Fase 2 RESEARCH: jalankan Prompt §2.1 (4 sub-tema) → §2.2 (verifikasi DOI).
  Checklist: 15 ref/sub-tema, 4 laporan LeapSpace, gauge Consensus, tabel Elicit,
  graf sitasi, laporan deep research, 0 DOI mati.
Fase 3 DRAFTING: jalankan Prompt §3.1 (skeleton → BERHENTI tunggu setuju → bab penuh)
  → §3.2 (parafrase + overlap report).
Fase 4 TEMPLATE: jalur IEEE → Prompt §4.1; jalur MAKALAH → Prompt §4.3 (+ §5.1 footnote).
  Kitab klasik tanpa DOI → sumber manual (shamela.ws/archive.org), TANDAI.
Fase 5 FINALISASI: verifikasi (Prompt 4 PROMPTS.md: 0 error/undefined, abstrak "Abstract"
  bila IEEE, table* , cover tampil) → optimasi bila > 3 MB (S1 saja) → Prompt §7.1.
Aturan global: TIDAK_TERSEDIA bila data tak ada; konflik dua versi; buku/kitab klasik
  TIDAK dipaksa ke Crossref; file POLISHED tidak dimodifikasi; JANGAN commit tanpa setuju.
Laporkan per fase: deliverable + sisa TODO + status.
```

- **Output diharapkan:** Makalah lengkapUBLISH sesuai jalur + seluruh artefak fase +
  commit/tag rilis.

---

## 9. Cheat Sheet

### 9.1 Prompt → Tool Mapping

| Prompt | Tool utama | Tool pendukung |
|---|---|---|
| §1.1 Ekstraksi chat | OpenCode + JSON API | grep (hitung level pesan) |
| §2.1 Multi-tool query | Perplexity, LeapSpace, Consensus, Elicit, Scholar, Rabbit, Papers, Scite, SciSpace, Gemini | DeepSeek (orkestrasi) |
| §2.2 Verifikasi DOI | OpenCode + Crossref API | SciSpace Citation Generator |
| §3.1 Generate Bab | Claude + DeepSeek | OpenCode (verifikasi terprogram) |
| §3.2 Parafrase | Claude | OpenCode (overlap) |
| §4.1 Build IEEE | OpenCode + pdflatex/bibtex | `build.ps1` |
| §4.2 Build Elsevier | OpenCode + pdflatex/bibtex | `build.ps1` |
| §4.3 Build Makalah | OpenCode + pdflatex | `build*.ps1` |
| §5.1 Footnote hybrid | OpenCode (+ manusia MANUAL) | `bibliography_map.json` |
| §6.1 Halaman judul | OpenCode + pdflatex | `DECISIONS.md` K-02–K-04 |
| §6.2 TTD KP | OpenCode + pdflatex | `KATA_PENGANTAR.md` |
| §7.1 Commit+tag+push | OpenCode (siapkan) + git | manusia (setujui) |
| §8.1 Universal | Semua di atas | checklist generik |

### 9.2 File → Template Mapping

| File/keluaran | Template | Engine/pipeline |
|---|---|---|
| Artikel jurnal (2 kolom, `[n]`) | `template-ieee/` | pdflatex 4-pass + bibtex |
| Varian Elsevier (1 kolom, `elsarticle`) | `template-elsevier/` (legacy) | pdflatex 4-pass + bibtex |
| Makalah kuliah (BAB I–III, footnote) | `template-makalah/` | pdflatex 2-pass |
| Varian jilid / softfile | `template-makalah/` + `build-jilid/build-softfile.ps1` | pdflatex 2-pass |
| Draft mentah/poles/parafrase | `makalah-hadis/draft/` (`*.md`, `*_POLISHED`, `*_PARAFRASE`) | markdown (bukan LaTeX) |
| Peta footnote | `makalah-hadis/bibliography_map.json` | JSON key→metadata |

### 9.3 Fase → Deliverable Mapping

| Fase (`PRD_MASTER.md` §7) | Prompt katalog | Deliverable |
|---|---|---|
| F1 Ekstraksi | §1.1 | `raw/` + `extracted/` + `memory/` |
| F2 Research | §2.1, §2.2 | Laporan + korpus terverifikasi + cache Crossref |
| F3 Drafting | §3.1, §3.2 | Skeleton + Bab I–III + PARAFRASE + overlap report |
| F4 Template | §4.1/§4.2/§4.3, §5.1, §6.1, §6.2 | `.tex` + `.bib`/footnote + cover; 0 error |
| F5 Finalisasi | Prompt 4–5 `PROMPTS.md`, §7.1 | PDF ≤ 3 MB + commit/tag ter-push |
| F6 Arsip & Rilis | §7.1 (langkah 4–5) | Tag rilis + `arsip/` + CHANGELOG |

> Catatan: `PROMPTS.md` Prompt 1–9 tetap menjadi referensi operasional harian OpenCode
> (paper baru, update existing, optimasi S1, verifikasi IEEE, troubleshooting compile,
> commit, resolve decisions, varian Elsevier, audit repo). Katalog ini merangkum +
> memperluasnya ke jalur Makalah Kuliah dan workflow research generik.

(End of file)
