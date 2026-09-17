# Troubleshooting LaTeX Umum

Katalog error umum untuk kedua format (IEEE + Makalah UIN). Untuk troubleshooting spesifik format, lihat juga `format-ieee.md` / `format-makalah-uin.md`.

## Error Fatal (compile gagal / output rusak)

| Error / Gejala | Penyebab | Solusi |
|---|---|---|
| `Undefined citation` / `[?]` / pustaka kosong (IEEE) | `bibtex` tidak dijalankan; atau `\cite{key}` tanpa padanan di `.bib` | Jalankan pipeline LENGKAP `pdflatex → bibtex → pdflatex ×2` (`.\build.ps1`); lalu cross-check `\cite{}` ↔ entri `.bib` |
| `File not found` / `ERROR: File cover... TIDAK DITEMUKAN` / cover blank | File gambar tidak di folder yang sama; atau nama di `\IfFileExists` ≠ nama di `\includegraphics` ≠ nama file aktual | Samakan ketiga nama; pastikan file di folder yang sama dengan `.tex` |
| `Missing $ inserted` (sering ×banyak, saat `\maketitle`) | Placeholder masih underscore (`<<NIM_1>>`) atau underscore tak ter-escape di teks | Ganti placeholder ke HYPHEN (`<<NIM-1>>`); escape underscore teks biasa (`\_`) |
| `There's no line here to end` di `\author` | Efek turunan error `Missing $` di atas | Hilang sendiri setelah placeholder diperbaiki |
| `missing \item` (bbl kosong) | Template IEEE tanpa `\cite` → bibtex keluarkan env kosong | Tambah sitasi demo `\cite{...}` sampai konten punya sitasi sendiri |
| bibtex `expecting '{' or '('` | Komentar `.bib` mengandung token `@misc`/`@article` | Tulis ulang komentar tanpa token itu |
| `! LaTeX Error: File ... not found` (package/class) | Paket LaTeX belum terinstal di TeX Live | Instal via `tlmgr install <paket>`; atau hapus paket yang tidak dipakai |
| Bibliografi kosong + halaman menyusut setelah tidy | Artefak `.bbl` terhapus, compile hanya 2× pdflatex tanpa bibtex | Wajib `bibtex` di pass 2 — jangan persingkat pipeline |
| TOC kosong / `??` (Makalah UIN) | Hanya 1-pass; TOC perlu pass ke-2 | Jalankan `pdflatex` 2× |

## Warning / Tampilan (biasanya non-fatal)

| Gejala | Penyebab | Solusi |
|---|---|---|
| `Overfull \hbox` di cover | Gambar full-page melebihi linewidth | Bungkus `\includegraphics` dengan `\makebox[\linewidth][c]{...}` |
| `Overfull \hbox` di teks/tabel | Baris/tabel terlalu lebar (URL panjang, kolom sempit) | Makalah UIN: `\sloppy` + `\raggedright` + `xurl`; IEEE tabel: pakai `table*` + `booktabs` + singkatan kolom; atau fix manual / ignore bila minor (<5pt) |
| `Underfull \hbox` di author block (IEEE) | Kosmetik — `\\` pemisah `\IEEEauthorblockN/A` | Abaikan |
| Abstrak jadi "Ringkasan" | Efek `babel` indonesian | Cek `\addto\captionsindonesian{\renewcommand{\abstractname}{Abstract}}` ada di preamble |
| Tabel overflow/tindih di 2 kolom (IEEE) | Pakai `table` biasa | Ganti ke `\begin{table*}...\end{table*}` |
| Cover dihitung hal.1 | Lupa reset counter | Tambah `\setcounter{page}{1}` setelah `titlepage` |
| Cover tidak full page / margin putih | Geometri tidak di-nol-kan | `\newgeometry{margin=0}` sebelum cover + `\restoregeometry` setelahnya |
| Nomor halaman muncul di cover/judul | Page style salah | Cover: `\pagenumbering{gobble}`; judul: `\thispagestyle{empty}`; arab dimulai setelahnya |
| `make` tidak dikenal (Windows) | `make` tidak tersedia di Windows | Pakai `.\build.ps1` (IEEE) atau `.\build-*.ps1` (Makalah UIN) |
| PDF > 3 MB | Cover PNG mengembang saat di-embed (99% penyebab) | S1: resize cover ke 2000 px + JPG q85, ganti referensi, compile ulang penuh. S2/S3 butuh Ghostscript; S5 DILARANG tanpa izin |

## Prosedur Diagnosis Standar

```
1. Jalankan pipeline penuh dan tangkap log (pdflatex → bibtex → pdflatex ×2, atau .\build.ps1)
2. Cari error/warning relevan: Missing $, no line here to end, missing \item,
   undefined citation, Overfull/Underfull, file not found
3. Cocokkan dengan tabel known-error di atas
4. Perbaiki akar masalah saja; placeholder <<...>> tetap utuh kecuali itu sumber errornya
5. Compile ulang sampai 0 error + 0 undefined
6. Laporkan: error awal | penyebab | perbaikan | status akhir compile
```
