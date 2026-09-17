# Format IEEE — Artikel 2 Kolom

Diekstrak dari `template-ieee/README_TEMPLATE.md` + `WORKFLOW.md §5`. Sumber otoritatif: `assets/template-ieee/template_ieee.tex` (struktur) dan `assets/template-ieee/referensi_template.bib`.

## Spesifikasi

| Item | Nilai |
|---|---|
| Document class | `\documentclass[journal]{IEEEtran}` |
| Kolom | 2 |
| Engine | `pdflatex` |
| Bibliography style | `\bibliographystyle{IEEEtran}` |
| Paket sitasi | `cite` (rentang otomatis `[1]–[3]`) |
| Bahasa | `babel` english+indonesian |

## Aturan 2 Kolom

- Class wajib `\documentclass[journal]{IEEEtran}` — jangan pakai `elsarticle` untuk output IEEE.
- Tabel lebar penuh: `\begin{table*}...\end{table*}` (bintang). `\begin{table}` biasa = sempit/tindih di 2 kolom. Pertimbangkan `booktabs` + singkatan kolom bila masih overflow.
- Gambar lebar penuh: `figure*` bila perlu; gambar kolom biasa: `figure`.
- Hapus `\linenumbers` di final (1000+ nomor baris bisa lolos ke final bila lupa).
- Header tiap halaman: `\markboth{konteks}{judul-pendek}`.
- Drop cap di paragraf pembuka: `\IEEEPARstart{G}{lobalisasi}...`.

## Aturan Sitasi Numeric

| Aturan | Benar | Salah |
|---|---|---|
| Sitasi tunggal | `\cite{latif2018}` → `[1]` | `[?]` (bibtex gagal) |
| Rentang sitasi | `\cite{a,b,c}` → `[1]–[3]` (paket `cite`) | Tulis manual `[1],[2],[3]` |
| Style | `\bibliographystyle{IEEEtran}` | Style non-IEEE |
| Pipeline | `pdflatex → bibtex → pdflatex ×2` (4-pass) | 2× pdflatex saja (`.bbl` hilang → 0 sitasi) |

- Template kosong tanpa `\cite` → bibtex keluarkan env kosong (`missing \item`). Solusi: pertahankan satu sitasi demo `\cite{contoh_artikel_jurnal}` sampai konten punya sitasi sendiri.
- Cross-check `\cite{}` ↔ entri `.bib` — target 100% cocok (0 sitasi yatim, 0 referensi menganggur).
- Komentar `.bib` jangan mengandung token `@misc`/`@article` — bibtex error `expecting '{' or '('`. Tulis ulang komentar tanpa token itu.

## Aturan Abstrak & Index Terms

- Label abstrak wajib `Abstract` — efek `babel` indonesian mengubahnya jadi "Ringkasan". Penangkal di preamble:
  ```latex
  \addto\captionsindonesian{\renewcommand{\abstractname}{Abstract}}
  ```
- Label `Abstract—` / `Index Terms—` = bold + em-dash.
- Abstrak: 150–250 kata. Keywords: 5–7 (di `IEEEkeywords`).
- Lingkungan:
  ```latex
  \begin{abstract} ... \end{abstract}
  \begin{IEEEkeywords} ... \end{IEEEkeywords}
  ```

## Aturan Lain

| Aturan | Benar | Salah |
|---|---|---|
| Istilah asing | `\textit{Staatsfundamentalnorm}`, `\textit{empty signifier}` | Upright / bold |
| Bold di body | DILARANG — hanya judul section & label abstrak/keywords | Bold untuk penekanan isi |
| Placeholder | `<<NAMA-PLACEHOLDER>>` (HYPHEN) | `<<NAMA_PLACEHOLDER>>` (underscore = error `Missing $`) |
| Cover | `\newgeometry{margin=0}` + `\IfFileExists{cover...}{\includegraphics[width=\paperwidth,height=\paperheight,keepaspectratio=false]{...}}` + `\restoregeometry` + `\setcounter{page}{1}` setelahnya | Cover dihitung hal.1 / margin putih / gambar kecil di-stretch |
| Author block | `panggilan+NIM vertikal`, afiliasi 1×, dosen di halaman judul | Format lama tanpa NIM |

## Cover

- Gambar A4 minimal 2480×3508 px (300 dpi). Simpan sebagai `cover_page.png` di folder yang sama dengan `.tex`.
- Nama di `\IfFileExists` = nama di `\includegraphics` = nama file aktual.
- `Overfull \hbox` di cover → bungkus `\includegraphics` dengan `\makebox[\linewidth][c]{...}`.
- Cover tidak dihitung hal.1 → `\setcounter{page}{1}` setelah `titlepage`.
- PDF > 3 MB: 99% penyebab = cover PNG mengembang saat di-embed. S1 = resize ke 2000 px + JPG q85, ganti referensi, compile ulang 4-pass.

## Compile

```powershell
.\build.ps1
# = pdflatex → bibtex → pdflatex → pdflatex (4-pass WAJIB, urutan ini)
```

- Windows tanpa `make`: pakai `.\build.ps1`. `make` hanya Linux/macOS, `build.sh` untuk Git Bash/WSL.
- `Underfull \hbox` di author block = kosmetik (`\\` pemisah `\IEEEauthorblockN/A`) — abaikan.

## Troubleshooting IEEE

| Masalah | Solusi |
|---|---|
| Cover blank / `ERROR: File cover_page.png TIDAK DITEMUKAN` | Pastikan file cover di folder yang sama; nama di `\IfFileExists` = nama di `\includegraphics` = nama file aktual |
| Undefined citation / `[?]` / pustaka kosong | Jalankan `.\build.ps1` LENGKAP (4-pass termasuk bibtex); cross-check `\cite{}` ↔ entri `.bib` |
| Abstrak jadi "Ringkasan" | Cek `\addto\captionsindonesian{\renewcommand{\abstractname}{Abstract}}` ada di preamble |
| `Missing $ inserted` (×banyak, saat `\maketitle`) | Placeholder masih underscore — ganti ke HYPHEN (`<<NIM-1>>`) |
| `There's no line here to end` di `\author` | Efek turunan error di atas — hilang setelah placeholder diperbaiki |
| `missing \item` (bbl kosong) | Tambah sitasi demo `\cite{...}` agar bibtex tidak keluarkan env kosong |
| bibtex `expecting '{' or '('` | Komentar `.bib` mengandung token `@misc` — tulis ulang komentar |
| Tabel overflow/tindih | Pakai `table*`; pertimbangkan `booktabs` + singkatan kolom |
| Bibliografi kosong + halaman menyusut setelah tidy | Artefak `.bbl` terhapus — wajib `bibtex` di pass 2 |
| `Overfull \hbox` di cover | Bungkus dengan `\makebox[\linewidth][c]{...}` |
| `make` tidak dikenal (Windows) | Pakai `.\build.ps1` |
