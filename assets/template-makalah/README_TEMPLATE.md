# Template Makalah Akademik Indonesia

Template LaTeX untuk makalah akademik standar kampus (1 kolom, Times 12pt, spasi 1.5).

## Spesifikasi

| Item | Nilai |
|---|---|
| Document class | `article` 12pt, A4 |
| Engine | `pdflatex` |
| Font | Times New Roman (paket `times`) 12pt |
| Spasi | 1.5 (`\onehalfspacing`) |
| Margin | kiri 4 cm, atas 4 cm, kanan 3 cm, bawah 3 cm |
| Kolom | 1 |
| Bahasa | Indonesia (`babel`) |
| Struktur | Cover → Kata Pengantar → Daftar Isi → BAB I–III → Daftar Pustaka |

## Struktur File

```
template-makalah/
├── template-makalah.tex   # main file
├── kp.tex                 # kata pengantar (include)
├── bab1.tex               # BAB I (include)
├── bab2.tex               # BAB II
├── bab3.tex               # BAB III
├── pustaka.tex            # Daftar Pustaka
├── pustaka.bib            # BibTeX opsional (tidak dipakai aktif)
├── cover.png              # cover image (full-page hal. 1)
├── build.ps1 / build.sh / Makefile
└── README_TEMPLATE.md
```

## Cara Pakai

```powershell
cd template-makalah
.\build.ps1
```

atau:

```bash
./build.sh
```

Pipeline: `pdflatex × 2` (2-pass, cukup karena tanpa BibTeX — TOC perlu pass ke-2).

## Konvensi Penulisan Isi

- Heading: `\section*{...}\addcontentsline{toc}{section}{...}` untuk BAB,
  `\subsection*{...}` untuk `A./B./C.`, `\subsubsection*{...}` untuk `1./2./...`
- Istilah Arab/transliterasi: `\textit{...}` (atau `\arabicterm{...}`)
- Sitasi: teks biasa `(Nama, Tahun)` — tanpa BibTeX
- Daftar pustaka: `enumerate` hanging indent di `pustaka.tex`
- Cover: `cover.png` full-page via `\newgeometry{margin=0}` + `\IfFileExists`;
  tanpa file pun tetap compile (fallback judul teks)

## Sumber Konten

Isi awal dikonversi dari `makalah-hadis/draft/` (file `*_POLISHED.md`,
`KATA_PENGANTAR.md`, `DAFTAR_PUSTAKA.md`). File `POLISHED` tidak dimodifikasi;
hasil konversi ada di `kp.tex`, `bab1.tex`, `bab2.tex`, `bab3.tex`, `pustaka.tex`.
Referensi: `makalah-hadis/draft/MAKALAH_FINAL.md` (11.462 kata).
