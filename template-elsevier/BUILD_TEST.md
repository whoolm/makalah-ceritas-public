# BUILD TEST — template-elsevier

Tanggal: 2026-09-13 (UTC). Engine: pdfTeX TeX Live 2026 + BibTeX 0.99e (Windows).
Pipeline: `pdflatex → bibtex → pdflatex → pdflatex` (setara `make`/`build.sh`/`.\build.ps1`).
Basis: konversi dari template-ieee v2.0.

## Hasil akhir: ✅ BERHASIL — 0 error

- `template_elsevier.pdf`: 2 halaman (cover full-page + frontmatter judul/penulis/abstrak/keywords + 5 section + ucapan terima kasih + daftar pustaka `[1]`), ~168 KB.
- bibtex (`elsarticle-num.bst`): `You've used 1 entry`, 0 warning/error; sitasi demo `[1]` ter-render; tidak ada undefined citation pada pass final.
- `grep "^!|Undefined|Error"` pada `.log` = bersih (satu-satunya hit "error" adalah nama paket `infwarerr`, bukan error kompilasi).
- Peringatan non-kritis: `csquotes: No style for language 'indonesian' (fallback)`, `pdfTeX warning duplicate page.1` (cover titlepage + frontmatter page counter — kosmetik, sama di varian IEEE), `natbib Citation may have changed` hilang setelah pass final.

## Mapping konversi yang diuji

| IEEE | Elsevier | Status |
|---|---|---|
| `\documentclass[journal]{IEEEtran}` | `\documentclass[preprint,12pt]{elsarticle}` | OK |
| `\bibliographystyle{IEEEtran}` | `\bibliographystyle{elsarticle-num}` | OK |
| `\IEEEauthorblockN/A` | `\author` + `\address` (+ dosen via `\tnotetext`) | OK |
| `\begin{IEEEkeywords}` | `\begin{keyword}` | OK |
| `\IEEEPARstart` | dihapus | OK (tidak ada di template) |
| `\markboth` | dihapus | OK |
| `\addto\captionsindonesian{...abstractname...}` | dihapus | OK |
| `\maketitle` | `\begin{frontmatter}...\end{frontmatter}` | OK |
| `\usepackage{cite}`, `\usepackage{stfloats}` | dihapus (konflik elsarticle) | OK |

## Catatan

- `build.sh`/`Makefile` menunjuk `PAPER=template_elsevier`; belum diuji via `make` di Windows (pakai pipeline manual setara).
- Cover `cover_page.png` = placeholder dari template-ieee — ganti dengan cover asli sebelum dipakai.
- Placeholder HYPHEN `<<...>>` dipertahankan (contoh: `<<NIM-1>>`, `<<SECTION-1-JUDUL>>`).
