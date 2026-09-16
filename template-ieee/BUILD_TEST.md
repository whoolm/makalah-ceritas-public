# BUILD TEST — template-ieee

Tanggal: 2026-09-13 (UTC). Engine: pdfTeX TeX Live 2026 + BibTeX 0.99e (Windows).
Pipeline: `pdflatex → bibtex → pdflatex → pdflatex` (setara `make`/`build.sh`; `make` tidak tersedia di Windows).

## Hasil akhir: ✅ BERHASIL — 0 error

- `template_ieee.pdf`: 2 halaman (cover full-page + judul/abstrak/keywords/5 section/ucapan terima kasih/daftar pustaka `[1]`), ~86 KB.
- bibtex: `Done.` tanpa error; sitasi demo `[1]` ter-render; tidak ada undefined citation.
- Satu-satunya peringatan: `Underfull \hbox` di blok penulis (baris 117–119, akibat `\\` pemisah baris `\IEEEauthorblockN/A`) — kosmetik, normal untuk template IEEE, bukan error.

## Error awal yang ditemukan & diperbaiki (tidak di-block, dicatat di sini)

| # | Error awal | Penyebab | Perbaikan (placeholder `<<...>>` tetap utuh) |
|---|------------|----------|-----------------------------------------------|
| 1 | `! Missing $ inserted` (×8, saat `\maketitle`) | Underscore di placeholder (`<<NIM_1>>`, `<<SECTION_1_JUDUL>>`, …) dibaca sebagai math subscript | Escape otomatis `_` → `\_` hanya di dalam token `<<...>>` (54 kemunculan; `grep '<<'` tetap menemukan semua) |
| 2 | `! LaTeX Error: There's no line here to end` (×3) | Efek turunan error #1 di blok `\author` | Hilang setelah perbaikan #1 |
| 3 | `! ... missing \item` (bbl kosong) | Template tanpa `\cite` → bibtex keluarkan `thebibliography` kosong | Tambah 1 baris demo `Contoh sitasi IEEE: \cite{contoh_artikel_jurnal}.` + komentar cara hapus |
| 4 | bibtex `expecting '{' or '('` di `referensi_template.bib:39` | Komentar `% ... @misc ...` — BibTeX tetap mem-parse token `@misc` | Tulis ulang komentar tanpa token `@misc` (`gunakan entri misc ...`) |
| 5 | `Overfull \hbox (313pt)` di cover | Gambar `\paperwidth` di dalam text block | Bungkus `\makebox[\linewidth][c]{...}` (geometri/newgeometry tak diubah) |

## Catatan

- `build.sh` belum dieksekusi di Windows (butuh Git Bash/WSL); isi skrip = pipeline yang diuji manual di atas.
- Cover `cover_page.png` = placeholder putih 2480×3508 px (dibuat via PIL) — ganti dengan cover asli sebelum dipakai.

## v2.0 — Smart Hybrid Upgrade (2026-09-13)

- Placeholder: `<<X\_Y>>` → `<<X-Y>>` (HYPHEN, 33/33, 0 backslash di placeholder). Satu `\_` tersisa dan sah: `cover\_page.png` di cabang error (bukan placeholder).
- Pipeline ulang pasca-hyphen: **COMPILE=SUCCESS, 0 error** (hyphen tak butuh escape — sesuai prediksi D1).
- File baru: `build.ps1`, `clean.ps1`, `DETECTION.log`, `DECISIONS.log`.
- Parent `.gitignore` + `template-ieee/` (tanpa commit ke parent).
