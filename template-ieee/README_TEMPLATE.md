# Template Artikel IEEE — UIN Walisongo Semarang

Template LaTeX siap pakai untuk artikel bergaya IEEE (2 kolom),
berbasis makalah "Pancasila sebagai Sistem Filsafat" (2026).

## Struktur File

| File | Fungsi |
|---|---|
| `template_ieee.tex` | File utama — placeholder `<<...>>` |
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
grep -n '<<' template_ieee.tex
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

## Aturan Format IEEE

| Aturan | Contoh |
|---|---|
| Abstrak label | `**Abstract—**` (bold + em-dash) |
| Kata kunci label | `**Index Terms—**` |
| Istilah asing | Miring: `\textit{Staatsfundamentalnorm}` |
| Bold di body | Dilarang, hanya judul & label |
| Sitasi | `\cite{key}` → `[1]` |
| Rentang sitasi | `\cite{a,b,c}` → `[1]–[3]` |

## Troubleshooting

| Masalah | Solusi |
|---|---|
| Cover TIDAK DITEMUKAN | Pastikan `cover_page.png` di folder yang sama dengan `.tex` |
| Undefined citation | Jalankan `make` (bibtex otomatis di antaranya) |
| Abstrak muncul "Ringkasan" | Pastikan `\addto\captionsindonesian` ada |
| Tabel lebar 2 kolom | Pakai `\begin{table*}` (bintang) |
| Cover tidak full page | `\newgeometry{margin=0}` + `keepaspectratio=false` |
| `make` tidak dikenal (Windows) | Pakai `.\build.ps1` |
| Placeholder underscore error (`Missing $`) | Sudah diperbaiki v2.0: placeholder kini HYPHEN (`<<NIM-1>>`), tanpa escape |

## Persyaratan
- TeX Live 2020+
- `pdflatex`, `bibtex` di `$PATH`
