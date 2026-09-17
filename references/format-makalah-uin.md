# Format Makalah UIN — 1 Kolom Skripsi-Grade

Diekstrak dari `template-makalah/README_TEMPLATE.md`. Sumber otoritatif: `assets/template-makalah/template-makalah.tex` (main JILID), `template-makalah-softfile.tex` (SOFTFILE), `halaman-judul.tex`, `kp.tex`, `bab1–3.tex`, `pustaka.tex`.

## Spesifikasi

| Item | Nilai |
|---|---|
| Document class | `article` 12pt, A4 (`\documentclass[12pt,a4paper,twoside]{article}` untuk JILID) |
| Engine | `pdflatex` |
| Font | Times New Roman (paket `times`) 12pt |
| Spasi | 1.5 (`\onehalfspacing`) |
| Margin | kiri 4 cm, atas 4 cm, kanan 3 cm, bawah 3 cm |
| Kolom | 1 |
| Bahasa | Indonesia (`babel`) |
| Paragraf | justified (bukan ragged-right), indent 1.27 cm, `\parskip` 0pt |
| Struktur | Cover → Halaman Judul → Kata Pengantar → Daftar Isi → BAB I–III → Daftar Pustaka |
| TOC depth | sampai subsection (`\setcounter{tocdepth}{2}`) |
| Pipeline | `pdflatex × 2` (2-pass, cukup karena tanpa BibTeX — TOC perlu pass ke-2) |

## Varian Build

| Varian | File utama | Margin | Script |
|---|---|---|---|
| JILID | `template-makalah.tex` | twoside, mirror (untuk dijilid) | `.\build-jilid.ps1` → `MAKALAH_JILID.pdf` |
| SOFTFILE | `template-makalah-softfile.tex` | oneside, simetris | `.\build-softfile.ps1` → `MAKALAH_SOFTFILE.pdf` |
| Keduanya | — | — | `.\build-all.ps1` |

Footer: nomor halaman di footer tengah (`\fancyfoot[C]{\thepage}`) — cocok untuk jilid. Header rule dimatikan (`\renewcommand{\headrulewidth}{0pt}`).

## Aturan 1 Kolom

- Heading: `\section*{...}\addcontentsline{toc}{section}{...}` untuk BAB, `\subsection*{...}` untuk `A./B./C.`, `\subsubsection*{...}` untuk `1./2./...`.
- Style heading: section = centered bold large; subsection/subsubsection = bold normalsize (via `titlesec`).
- Setiap BAB di file sendiri (`bab1.tex`, `bab2.tex`, `bab3.tex`) dan di-`\input` dengan `\clearpage` di antaranya.
- Daftar isi otomatis via `\tableofcontents` (makanya perlu 2-pass).
- Setiap section utama (`KATA PENGANTAR`, `DAFTAR ISI`, `DAFTAR PUSTAKA`) didaftarkan manual ke TOC via `\addcontentsline` + `\phantomsection`.

## Aturan Footnote Skripsi-Grade

- Sitasi: `\footnote{...}` inline — teks biasa `(Nama, Tahun)` di body, detail penuh di footnote. Tanpa BibTeX (`.bib` ada tapi tidak dipakai aktif).
- Kutipan pertama (lengkap):
  ```latex
  \footnote{A. Musadad, "Articulating the prophetic authority: Some notes on the nature of hadith collection in al-Muwatta' and musannaf literature," \textit{Jurnal Studi Ilmu-Ilmu Al-Qur'an dan Hadis}, vol. 27, no. 1, hlm. 351--373, 2026.}
  ```
- Kutipan ulang (singkat — nama + judul pendek):
  ```latex
  \footnote{Musadad, "Articulating the Prophetic Authority.";}
  ```
- Multi-sumber dalam satu footnote dipisah `;`.
- Judul jurnal/buku di dalam footnote: `\textit{...}`.
- Rentang halaman: `--` (en-dash LaTeX) mis. `hlm. 351--373`.
- Istilah Arab/transliterasi di body: `\textit{...}` (atau `\arabicterm{...}`, ekuivalen dengan `\textit`).

## Aturan Halaman Judul

Urutan dari atas (`halaman-judul.tex`):

```
1. Header: {\Large\bfseries MAKALAH}
2. Judul makalah: {\Large\bfseries ... } (bisa 2–3 baris)
3. Logo UIN: \IfFileExists{logo_walisongo.png}{\includegraphics[width=3cm]{...}}{} (opsional — tetap compile tanpa file)
4. "Disusun oleh:" (bold)
5. Nama penulis + NIM per orang:
   {\large Nama Lengkap} \\ {\large NIM: 260204XXXXX}
6. Dosen Pengampu (bold italic label + nama lengkap bergelar)
7. Institusi (bold, caps):
   PROGRAM STUDI ... / FAKULTAS ... / UNIVERSITAS ISLAM NEGERI WALISONGO / SEMARANG
```

- Semua centered (`\begin{center}...\end{center}`), `\thispagestyle{empty}` (tanpa nomor halaman).
- Nomor halaman arab dimulai setelah halaman judul (`\pagenumbering{arabic}`, `\setcounter{page}{1}`).

## Aturan TTD Kata Pengantar

- File `kp.tex`: teks syukur → maksud/tujuan makalah → terima kasih (dosen pengampu disebut nama + jabatan) → kesadaran keterbatasan + harapan kritik → penutup manfaat.
- Judul makalah di dalam kata pengantar: `\textbf{\textit{...}}`.
- Blok tanda tangan: dua `minipage` berdampingan (0.45\textwidth tiap sisi):
  - Kiri: `Mengetahui, Dosen Pengampu,` + jeda 2.5 cm + nama dosen bold (2 baris bila bergelar panjang).
  - Kanan: `Semarang, <tanggal>, Penulis,` + jeda 2.5 cm + nama-nama penulis bold.
- Isi `kp.tex` tanpa heading — heading `KATA PENGANTAR` ada di file utama.

## Aturan Daftar Pustaka

- File `pustaka.tex`: `enumerate` dengan hanging indent:
  ```latex
  \begin{enumerate}[leftmargin=1.5cm,itemindent=-1.5cm,label={},itemsep=4pt,parsep=2pt]
  ```
- Format per entri: `Nama, I. (Tahun). Judul dengan \textit{istilah-asing}. \textit{Nama Jurnal}, \textit{Vol}(no), hlm. \url{doi}`.
- Data tak terverifikasi: tandai `[Halaman --- VERIFIKASI_MANUAL]` atau `[VERIFIKASI_MANUAL --- Crossref: 404]` — jangan dikarang.
- Dibungkus `\sloppy` + `\raggedright` agar URL panjang tidak overflow.

## Cover

- `cover.png` full-page via `\newgeometry{margin=0cm}` + `\IfFileExists` + `\restoregeometry` + `\clearpage`.
- `\enlargethispage{5pt}` + `\pagenumbering{gobble}` agar image setinggi `\paperheight` tidak tumpah ke hal. 2 (pembulatan internal pdfTeX).
- Tanpa file pun tetap compile (fallback judul teks `MAKALAH`).

## Troubleshooting Makalah UIN

| Masalah | Solusi |
|---|---|
| TOC kosong / halaman `??` | Jalankan pass ke-2 (`pdflatex` lagi) — TOC butuh 2-pass |
| Cover tumpah ke hal. 2 | Pastikan `\enlargethispage{5pt}` + `\pagenumbering{gobble}` + `\newgeometry{margin=0cm}` ada |
| URL di pustaka overflow | Pastikan `\sloppy` + `\raggedright` + paket `xurl` ter-load |
| Logo tidak tampil tapi compile sukses | Normal — `\IfFileExists` fallback kosong; pastikan `logo_walisongo.png` di folder yang sama bila ingin tampil |
| `Missing $` | Escape underscore (`\_`) atau data `VERIFIKASI_MANUAL` mengandung karakter khusus — cek baris terkait |
| Nomor halaman muncul di cover/judul | Pastikan `\thispagestyle{empty}` (judul) dan `\pagenumbering{gobble}` (cover); arab dimulai setelahnya |
| Margin jilid salah sisi | Pastikan pakai file/varian yang benar: JILID = twoside; SOFTFILE = oneside |
