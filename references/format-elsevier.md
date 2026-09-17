# Format Elsevier — Aturan & Panduan

Template: `assets/template-elsevier/`
Document class: `elsarticle`
Engine: pdflatex
Build: 4-pass (pdflatex → bibtex → pdflatex ×2)

## Spesifikasi Format

| Aspek | Nilai |
|---|---|
| Document class | `\documentclass[preprint,12pt]{elsarticle}` |
| Kolom | 1 kolom |
| Font | Times 12pt (default elsarticle) |
| Spasi | 1.5 |
| Margin | 1.5 cm simetris |
| Struktur | Frontmatter → Section 1-5 → References |
| Sitasi | Numeric `\cite{}` → `[1]` |
| Bibliografi | `\bibliographystyle{elsarticle-num}` |
| Abstrak | `\begin{abstract}...\end{abstract}` |
| Keywords | `\begin{keyword}...\end{keyword}` |
| Author | `\author{}` + `\address{}` |
| Cover | 1 halaman full-page (opsional) |

## Frontmatter Structure

```latex
\begin{frontmatter}
    \title{Judul Paper}
    \author[Nama1]{Nama Lengkap 1}
    \address[Institusi]{Program Studi \\ Fakultas \\ Universitas}
    \begin{abstract}
        ...
    \end{abstract}
    \begin{keyword}
        kata1, kata2, kata3
    \end{keyword}
\end{frontmatter}
```

## Perbedaan dari IEEE

| Aspek | IEEE | Elsevier |
|---|---|---|
| Document class | `IEEEtran[journal]` | `elsarticle[preprint,12pt]` |
| Kolom | 2 | 1 |
| Author block | `\IEEEauthorblockN{}` + `\IEEEauthorblockA{}` | `\author{}` + `\address{}` |
| Keywords | `\begin{IEEEkeywords}` | `\begin{keyword}` |
| Bibliographystyle | `IEEEtran.bst` | `elsarticle-num.bst` |
| Frontmatter wrapper | Tidak ada | `\begin{frontmatter}...\end{frontmatter}` |

## Troubleshooting

| Error | Solusi |
|---|---|
| `elsarticle.cls not found` | Install `texlive-publishers` |
| `microtype font expansion failed` | Tambah `\usepackage[T1]{fontenc}` + `\usepackage{lmodern}` sebelum `microtype` |
| Cover overfull 313pt | Bungkus `\includegraphics` dengan `\makebox[\linewidth][c]{}` |
| `babel-indonesian` missing | Install `texlive-lang-other` |

## Contoh Realisasi

- `template-elsevier/` (tag `elsevier-v1.1`) — baseline konversi dari IEEE
- Sudah tested compile di Windows dan Linux (WSL Ubuntu)

## Catatan Legacy

- Versi saat ini = konversi langsung dari template IEEE
- Belum ada paper riil yang submit ke jurnal Elsevier
- Kalau nanti pakai untuk submit, lakukan smoke test 2 halaman dulu
