# WORKFLOW — Default Project

> SOP operasional end-to-end. Dari paper baru sampai PDF final.

## 0. Ringkasan Proyek

**Makalah Ceritas** awalnya PRD platform asisten penulisan makalah (6 chat DeepSeek, 376 pesan, baseline `v1.0-prd`), tapi pembangunan aplikasi (RISE 1–6) eksplisit DITUNDA (NG-01). Jalur yang dieksekusi = **LLM-only**: DeepSeek (orkestrasi) → Claude (tulis/revisi) → OpenCode (eksekusi) + tools riset multi-AI. Output nyata: makalah "Pancasila sebagai Sistem Filsafat dan Ideologi Negara" (IEEEtran journal 2 kolom, 19 hlm, 10150 kata, 422 sitasi, PDF 0.65 MB) + template reusable `template-ieee/` (tag `template-v2.0`, compile 0 error). SOP ini mengatur cara bikin paper baru, update paper existing, compile, optimasi, dan commit — tanpa mengarang (data hilang = `TIDAK_TERSEDIA`, konflik dicatat dua versi).

## 1. Struktur & Tanggung Jawab

| File/Folder | Isi | Kapan diubah |
|---|---|---|
| `template-ieee/template_ieee.tex` | Template utama, placeholder `<<...>>` HYPHEN | Hampir tidak pernah; ubah hanya untuk perbaikan template + tag baru |
| `template-ieee/referensi_template.bib` | Template daftar pustaka | Sama seperti di atas |
| `template-ieee/build.ps1`, `build.sh`, `Makefile`, `clean.ps1` | Build 4-pass + bersih-bersih | Hanya jika pipeline berubah |
| `template-ieee/README_TEMPLATE.md` | Cara pakai template | Saat aturan format berubah |
| `template-ieee/DECISIONS.log`, `BUILD_TEST.md` | Keputusan + log uji compile | Setiap rilis template |
| `makalah_pancasila_ieee.tex` | Makalah final (contoh realisasi) | Saat revisi isi/format |
| `pancasila_referensi_fix.bib` | Daftar pustaka acuan (72/72 cocok per C1) | Hati-hati: konflik K-01 vs `final` — cross-check dulu |
| `cover_page.png` / `cover_page_opt.jpg` | Cover original 5.66 MB / optimized 518 KB | `opt.jpg` yang dipakai PDF saat ini |
| `PRD.md`, `TRACEABILITY.md/.csv`, `METODOLOGI_RESEARCH.md` | Dokumentasi produk (baseline) | Hanya via prosedur `CONTRIBUTING.md` |
| `PENDING_DECISIONS.md` | PD-01–PD-13 + K-01–K-13 | Manusia yang memutuskan; OpenCode hanya mencatat |
| `PDF_OPTIMIZATION.md` | Log optimasi + pelajaran pipeline | Setiap sesi optimasi |
| `arsip/` | 43 file iterasi lama (`final/revisi/gabungan/fix`, `.bib` lama) | Hanya terima file lama; jangan edit |
| `raw/` → `extracted/` → `memory/` | Data mentah → transkrip → konsolidasi 6 chat | Jangan diubah (baseline) |

Catatan repo: `template-ieee/` adalah nested git repo tersendiri. Parent `.gitignore` mengecualikan stub `raw/*.html` dan `.env`.

## 2. Tools & Environment

| Tool | Status | Fungsi |
|---|---|---|
| pdflatex (TeX Live 2026) | ✅ | Compile LaTeX |
| bibtex (0.99e) | ✅ | Proses sitasi (wajib di pass 2) |
| Python 3.11 + PIL + PyMuPDF | ✅ | Image processing + audit PDF (kata/sitasi/halaman) |
| pdfimages | ✅ | Inspeksi image di dalam PDF |
| `.\build.ps1` / `make` / `.\build.sh` | ✅ | Pipeline 4-pass (Windows pakai `build.ps1`) |
| Ghostscript (`gswin64c`), `pdftk`, ImageMagick | ❌ | Tidak tersedia — strategi S2/S3 optimasi tidak bisa jalan |
| Make (Windows) | ❌ | Tidak tersedia di Windows — pakai `.\build.ps1` |

Engine final = **pdflatex** (simpel, tanpa TikZ/fontspec). xelatex/lualatex hanya relevan untuk cover programatik (K-07, tidak dipakai karena cover = image).

## 3. Workflow Standar — Paper Baru (7 Fase)

### Fase 1: Setup (5 menit)

```
1. Copy template-ieee/ → folder paper baru (jangan edit template asli in-place)
2. Rename: template_ieee.tex → <nama-paper>.tex ; referensi_template.bib → referensi.bib
3. Di .tex: ubah \bibliography{referensi_template} → \bibliography{referensi}
4. Siapkan cover: gambar A4 min 2480×3508 px, simpan sebagai cover_page.png di folder yang sama
5. Daftar placeholder: grep -n '<<' <nama-paper>.tex
```

### Fase 2: Isi Konten (durasi bebas)

```
1. Edit .tex → ganti SEMUA placeholder <<...>> (format HYPHEN, mis. <<JUDUL-PAPER-LENGKAP>>, <<NIM-1>>)
   - Jangan pakai underscore di placeholder (menyebabkan `Missing $ inserted`)
   - Author block: panggilan+NIM vertikal (format terakhir yang diminta), afiliasi 1×, dosen di halaman judul
2. Edit .bib → tambah referensi (verifikasi DOI via Crossref; entri tanpa year = tandai % TODO(editor), JANGAN dikarang)
3. Terapkan aturan format §5 sejak awal (italic asing, sitasi \cite, table*, tanpa bold body)
```

### Fase 3: Compile

```powershell
.\build.ps1
# = pdflatex → bibtex → pdflatex → pdflatex (4-pass WAJIB, urutan ini)
# 2x pdflatex SAJA itu SALAH: .bbl hilang → bibliografi kosong, 0 sitasi (pelajaran di PDF_OPTIMIZATION.md)
```

Cek PDF muncul + tidak ada error fatal di log.

### Fase 4: Verifikasi

```
- [ ] Halaman sesuai (cover tidak dihitung hal.1 → \setcounter{page}{1} setelah titlepage)
- [ ] Sitasi ter-render (0 [?], 0 undefined citation; cross-check \cite ↔ .bib, target 100% cocok)
- [ ] Abstrak berlabel "Abstract" (bukan "Ringkasan")
- [ ] Label Abstract—/Index Terms— bold+em-dash
- [ ] Tabel tidak overflow (pakai table*, cek visual)
- [ ] Istilah asing italic (\textit), bold hanya judul/label
- [ ] Cover full-page tajam, tidak blank (cek \IfFileExists + file di folder yang sama)
- [ ] Kata/abstrak: 150–250 kata, keywords 5–7 (standar paper ini: ~230 kata, 6 keywords)
```

### Fase 5: Optimasi PDF (jika > 3 MB)

Lihat `PROMPTS.md` prompt #3. Ringkasan: penyebab 99% ukuran = cover PNG yang mengembang saat di-embed. Strategi S1 = resize cover ke 2000 px + JPG q85 (`cover_page_opt.jpg`), ganti referensi `\includegraphics`, compile ulang 4-pass, verifikasi halaman/kata/sitasi identik. S2/S3 butuh Ghostscript (tidak ada). S5 DILARANG tanpa izin eksplisit.

### Fase 6: Commit

```
git status                         # pastikan hanya file yang dimaksud
git add <nama-paper>.tex <nama-paper>.pdf referensi.bib cover_page.png
git commit -m "feat: ..."          # lihat konvensi §6
git tag paper-v1.0                 # untuk rilis paper
```

Aturan: hapus file `.bak` sebelum commit; jangan commit artefak (`*.aux/.log/.bbl/.blg/.out/.spl`) kecuali disepakati.

### Fase 7: Arsip (jika iterasi)

```
Move-Item versi_lama.tex arsip/
# arsip/ hanya untuk file lama (final/revisi/gabungan/fix) — jangan edit isinya
```

## 4. Workflow — Update Paper Existing

Sama seperti §3 tanpa Fase 1:

```
1. Edit .tex/.bib langsung (contoh: makalah_pancasila_ieee.tex + pancasila_referensi_fix.bib)
2. WAJIB cross-check \cite ↔ .bib dulu bila ada konflik acuan (K-01: fix vs final)
3. .\build.ps1 (4-pass penuh — jangan dipersingkat)
4. Verifikasi §3-Fase 4
5. Optimasi bila > 3 MB
6. Commit dengan pesan fix:/docs:/perf: sesuai jenis perubahan
```

Pelajaran nyata (PDF_OPTIMIZATION.md): setelah repo tidy (artefak dibersihkan), compile 2× pdflatex menghasilkan PDF 17 hlm/0 sitasi — selalu jalankan pipeline LENGKAP termasuk bibtex.

## 5. Aturan Format IEEE

| Aturan | Benar | Salah |
|---|---|---|
| Class | `\documentclass[journal]{IEEEtran}` | elsarticle untuk output IEEE |
| Abstrak label | `Abstract` via `\addto\captionsindonesian{\renewcommand{\abstractname}{Abstract}}` | "Ringkasan" (efek babel indonesian) |
| Label abstrak/keywords | `**Abstract—**` / `**Index Terms—**` bold + em-dash | Tanpa em-dash / tidak bold |
| Istilah asing | `\textit{Staatsfundamentalnorm}`, `\textit{empty signifier}` | Upright / bold |
| Bold di body | DILARANG — hanya judul section & label di atas | Bold untuk penekanan isi |
| Sitasi | `\cite{latif2018}` → `[1]` | `[?]` (bibtex gagal) |
| Rentang sitasi | `\cite{a,b,c}` → `[1]–[3]` (paket `cite`) | Tulis manual `[1],[2],[3]` |
| Tabel lebar penuh | `\begin{table*}...\end{table*}` | `\begin{table}` (sempit/tindih di 2 kolom) |
| Nomor baris | Hapus `\linenumbers` di final | 1000+ nomor baris lolos ke final |
| Header | `\markboth{konteks}{judul-pendek}` | Tanpa header |
| Drop cap | `\IEEEPARstart{G}{lobalisasi}...` di paragraf pembuka | Huruf normal |
| Cover | `\newgeometry{margin=0}` + `\IfFileExists{cover...}{\includegraphics[width=\paperwidth,height=\paperheight,keepaspectratio=false]{...}}` + `\restoregeometry` + `\setcounter{page}{1}` setelahnya | Cover dihitung hal.1 / margin putih / gambar kecil di-stretch |
| Placeholder | `<<NAMA-PLACEHOLDER>>` (HYPHEN) | `<<NAMA_PLACEHOLDER>>` (underscore = error `Missing $`) |
| Pustaka | `\bibliographystyle{IEEEtran}` | Style non-IEEE |

## 6. Git Conventions

| Action | Message |
|---|---|
| Commit fitur | `feat: ...` |
| Commit fix | `fix: ...` |
| Commit docs | `docs: ...` |
| Commit perf | `perf: ...` |
| Commit chore | `chore: ...` |

Tag conventions:

- `v1.0-prd` — baseline PRD (sudah ada, jangan digeser)
- `template-v2.0` — template final (sudah ada)
- `paper-v1.0` — paper final (pakai untuk rilis paper baru)

Aturan tambahan: OpenCode TIDAK memutuskan PD/K — manusia memilih, OpenCode mengeksekusi + mencatat di `CHANGELOG.md` (format: tanggal UTC, file, alasan, bahasa Indonesia).

## 7. Troubleshooting

| Masalah | Solusi |
|---|---|
| Cover blank / `ERROR: File cover_page.png TIDAK DITEMUKAN` | Pastikan file cover di folder yang sama dengan `.tex`; nama di `\IfFileExists` = nama di `\includegraphics` = nama file aktual |
| Undefined citation / `[?]` / pustaka kosong | Jalankan `.\build.ps1` LENGKAP (4-pass termasuk bibtex); lalu cross-check `\cite{}` ↔ entri `.bib` (konflik K-01: pastikan acuan `fix` vs `final` tunggal) |
| Abstrak jadi "Ringkasan" | Cek `\addto\captionsindonesian{\renewcommand{\abstractname}{Abstract}}` ada di preamble |
| `Missing $ inserted` (×banyak, saat `\maketitle`) | Placeholder masih underscore — ganti ke HYPHEN (`<<NIM-1>>`, bukan `<<NIM_1>>`) |
| `There's no line here to end` di `\author` | Efek turunan error di atas — hilang setelah placeholder diperbaiki |
| `missing \item` (bbl kosong) | Template tanpa `\cite` → tambah sitasi demo `\cite{...}` agar bibtex tidak keluarkan env kosong |
| bibtex `expecting '{' or '('` | Komentar `.bib` mengandung token `@misc` — tulis ulang komentar tanpa token itu |
| Tabel overflow/tindih di 2 kolom | Pakai `table*` bukan `table`; pertimbangkan `booktabs` + singkatan kolom |
| PDF > 10 MB (atau > 3 MB) | Compress cover PNG→JPG 2000 px q85 (lihat PROMPTS.md #3); teks/font vektor hanya ~0.1 MB jadi jangan dioprek |
| Bibliografi kosong + halaman menyusut setelah tidy | Artefak `.bbl` terhapus — wajib `bibtex` di pass 2, bukan 2× pdflatex saja |
| `Overfull \hbox` di cover | Bungkus `\includegraphics` dengan `\makebox[\linewidth][c]{...}` |
| `make` tidak dikenal (Windows) | Pakai `.\build.ps1`; `make` hanya Linux/macOS, `build.sh` untuk Git Bash/WSL |
| `Underfull \hbox` di author block | Kosmetik, normal untuk IEEE (`\\` pemisah `\IEEEauthorblockN/A`) — abaikan |

## 8. Lihat Juga

- `CONTEXT.md` — briefing singkat (baca 1 menit)
- `PROMPTS.md` — prompt siap pakai (paper baru, update, optimasi, verifikasi)
- `template-ieee/README_TEMPLATE.md` — cara pakai template
- `template-ieee/template_ieee.tex` — struktur LaTeX acuan
- `template-ieee/BUILD_TEST.md` — riwayat error compile + perbaikan
- `makalah_pancasila_ieee.tex` — contoh realisasi lengkap
- `PRD.md` — requirement (§5 FR, §6 NFR, §15–§19)
- `PENDING_DECISIONS.md` — keputusan terbuka (JANGAN diputuskan sepihak)
- `PDF_OPTIMIZATION.md` — log optimasi + pelajaran pipeline
