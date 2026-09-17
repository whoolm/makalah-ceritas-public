# Template Artikel Elsevier — UIN Walisongo Semarang

Template LaTeX siap pakai untuk artikel bergaya Elsevier (`elsarticle`, preprint 1 kolom),
konversi dari template IEEE v2.0 (basis makalah "Pancasila sebagai Sistem Filsafat", 2026).

## Struktur File

| File | Fungsi |
|---|---|
| `template_elsevier.tex` | File utama — placeholder `<<...>>` |
| `referensi_template.bib` | Template daftar pustaka |
| `cover_page.png` | Cover full-page (ganti punya Anda) |
| `Makefile` | Build script (`make`, Linux/macOS) |
| `build.sh` | Build script (Git Bash/WSL) |
| `build.ps1` / `clean.ps1` | Build + bersih-bersih (Windows PowerShell) |
| `README_TEMPLATE.md` | File ini |

## Cara Pakai

### 1. Siapkan Cover
Gambar A4 minimal 2480x3508 px (300 dpi). Simpan sebagai `cover_page.png`.

### 2. Isi Placeholder
Placeholder memakai format HYPHEN (strip, tanpa escape), contoh:
`<<JUDUL-PAPER-LENGKAP>>`, `<<AUTHOR-1>>`, `<<NIM-1>>`, `<<KATA-KUNCI-1>>`.
```bash
grep -n '<<' template_elsevier.tex
```
Ganti semua `<<...>>`.

### 3. Isi Referensi
Rename `referensi_template.bib` → `referensi.bib`.
Edit `.tex`:
```latex
\bibliography{referensi}
```

### 4. Compile
```bash
make
```
Atau:
```bash
./build.sh
```

### 4b. Build di Windows (PowerShell, tanpa `make`)
```powershell
.\build.ps1
.\clean.ps1
```

### 5. Bersihkan
```bash
make clean
make cleanall
```

## Perbedaan vs IEEE (mapping konversi)

| IEEE (`template_ieee.tex`) | Elsevier (`template_elsevier.tex`) |
|---|---|
| `\documentclass[journal]{IEEEtran}` | `\documentclass[preprint,12pt]{elsarticle}` |
| `\bibliographystyle{IEEEtran}` | `\bibliographystyle{elsarticle-num}` |
| `\IEEEauthorblockN` + `\IEEEauthorblockA` | `\author{...}` + `\address{...}` (+ dosen via `\tnotetext`) |
| `\begin{IEEEkeywords}` | `\begin{keyword}` |
| `\IEEEPARstart` (drop cap) | Dihapus (Elsevier tidak pakai) |
| `\markboth{}{}` | Dihapus (tidak dipakai) |
| `\addto\captionsindonesian{\renewcommand{\abstractname}{Abstract}}` | Dihapus (Elsevier default "Abstract") |
| `\maketitle` | Diganti `\begin{frontmatter}...\end{frontmatter}` |
| 2 kolom | 1 kolom preprint |

## Aturan Format Elsevier

| Aturan | Contoh |
|---|---|
| Abstrak label | `Abstract` (default class) |
| Kata kunci | `\begin{keyword}...\end{keyword}` |
| Istilah asing | Miring: `\textit{Staatsfundamentalnorm}` |
| Sitasi numerik | `\cite{key}` → `[1]` (`elsarticle-num`) |
| Afiliasi | `\address{...}` (satu blok bersama) |

## Troubleshooting

| Masalah | Solusi |
|---|---|
| Cover TIDAK DITEMUKAN | Pastikan `cover_page.png` di folder yang sama dengan `.tex` |
| Undefined citation | Jalankan `make` / `.\build.ps1` (bibtex otomatis di antaranya) |
| `elsarticle.cls not found` | Install paket `elsarticle` via TeX Live (`tlmgr install elsarticle`) |
| `make` tidak dikenal (Windows) | Pakai `.\build.ps1` |
| Placeholder underscore error (`Missing $`) | Placeholder kini HYPHEN (`<<NIM-1>>`), tanpa escape |

## Persyaratan
- TeX Live 2020+ (dengan paket `elsarticle`)
- `pdflatex`, `bibtex` di `$PATH`
