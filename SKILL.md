---
name: makalah-ceritas
description: Tulis dan compile makalah LaTeX tiga format — artikel IEEE 2-kolom (IEEEtran, sitasi numeric), makalah akademik UIN 1-kolom (Times 12pt, footnote skripsi-grade), dan artikel Elsevier preprint 1-kolom (elsarticle, sitasi numeric). Use when user asks to write, revise, compile, optimize, verify, or troubleshoot a paper/makalah/artikel, mentions IEEE, UIN, Elsevier, elsarticle, template-makalah, template-ieee, template-elsevier, pdflatex, bibtex, sitasi, footnote, cover page, kata pengantar, daftar pustaka, or needs build.ps1 scripts.
---

# Makalah Ceritas Skill

SOP menulis makalah LaTeX dari template sampai PDF final — tanpa mengarang (data tak ada = `TIDAK_TERSEDIA`, konflik dicatat dua versi, jangan diputuskan sepihak).

Tiga format didukung:
- **IEEE** — artikel 2 kolom (`IEEEtran`, pdflatex, sitasi numeric `\cite` → `[1]`). Template: `assets/template-ieee/`.
- **Makalah UIN** — makalah kampus 1 kolom (article 12pt Times, spasi 1.5, footnote skripsi-grade). Template: `assets/template-makalah/`.
- **Elsevier** — artikel preprint 1 kolom (`elsarticle`, pdflatex, sitasi numeric `\cite` → `[1]`). Template: `assets/template-elsevier/`.

## Workflow

### 1. Pilih format

| Permintaan user | Format | Template | Build |
|---|---|---|---|
| artikel, jurnal, IEEE, 2 kolom, sitasi `[1]` | IEEE | `assets/template-ieee/` | 4-pass: `pdflatex → bibtex → pdflatex ×2` |
| makalah, tugas kuliah, BAB I–III, kata pengantar, footnote | Makalah UIN | `assets/template-makalah/` | 2-pass: `pdflatex ×2` (tanpa BibTeX; TOC perlu pass ke-2). Dua varian: JILID (twoside) vs SOFTFILE (oneside) |
| artikel Elsevier, elsarticle, preprint, 1 kolom | Elsevier | `assets/template-elsevier/` | 4-pass: `pdflatex → bibtex → pdflatex ×2` |

Kalau user tidak menyebut format, tanya dulu sebelum mulai.

### 2. Setup paper baru — IEEE

```
1. Copy assets/template-ieee/ → folder paper baru (jangan edit template asli in-place)
2. Rename: template_ieee.tex → <nama-paper>.tex ; referensi_template.bib → referensi.bib
3. Di .tex: ubah \bibliography{referensi_template} → \bibliography{referensi}
4. Siapkan cover: gambar A4 min 2480×3508 px, simpan sebagai cover_page.png di folder yang sama
5. Daftar placeholder: grep -n '<<' <nama-paper>.tex
```

### 3. Setup paper baru — Makalah UIN

```
1. Copy assets/template-makalah/ → folder paper baru
2. File utama: template-makalah.tex (JILID, twoside) atau template-makalah-softfile.tex (SOFTFILE, oneside)
3. Edit: halaman-judul.tex (nama/NIM/dosen), kp.tex (kata pengantar + TTD), bab1–3.tex, pustaka.tex
4. Cover: cover.png full-page via \IfFileExists (tanpa file pun tetap compile — fallback judul teks)
5. Compile: .\build-jilid.ps1 / .\build-softfile.ps1 / .\build-all.ps1 (keduanya)
```

### 4. Setup paper baru — Elsevier

```
1. Copy assets/template-elsevier/ → folder paper baru (jangan edit template asli in-place)
2. Rename: template_elsevier.tex → <nama-paper>.tex ; referensi_template.bib → referensi.bib
3. Di .tex: ubah \bibliography{referensi_template} → \bibliography{referensi}
4. Compile: .\build.ps1 (4-pass: pdflatex → bibtex → pdflatex ×2)
5. Verifikasi: 0 error, 0 undefined, sitasi [1] ter-render, abstrak + keywords muncul, tabel tidak overflow
```

### 5. Isi konten

- Ganti SEMUA placeholder `<<...>>` format HYPHEN (`<<NIM-1>>`, bukan `<<NIM_1>>` — underscore = error `Missing $`).
- Yang datanya belum ada tulis `TIDAK_TERSEDIA`, jangan dikarang.
- Terapkan aturan format sejak awal — lihat `references/format-ieee.md`, `references/format-makalah-uin.md`, atau `references/format-elsevier.md`.
- Verifikasi DOI via Crossref untuk entri `.bib` baru; entri tanpa year = tandai `% TODO(editor)`.

### 6. Compile

- IEEE: `.\build.ps1` (4-pass WAJIB — 2× pdflatex saja = `.bbl` hilang → bibliografi kosong, 0 sitasi).
- Makalah UIN: `.\build-jilid.ps1` / `.\build-softfile.ps1` (2-pass pdflatex, tanpa bibtex).
- Elsevier: `.\build.ps1` (4-pass: pdflatex → bibtex → pdflatex ×2, sama seperti IEEE).
- Target: 0 error, 0 undefined citation. `Underfull \hbox` di author block = kosmetik, abaikan.

### 7. Verifikasi

- IEEE: halaman sesuai (cover tidak dihitung hal.1 → `\setcounter{page}{1}`), sitasi ter-render (0 `[?]`), abstrak berlabel "Abstract", label `Abstract—`/`Index Terms—` bold+em-dash, tabel pakai `table*`, istilah asing `\textit`, tanpa bold body, cover full-page tajam.
- Makalah UIN: margin kiri 4cm/atas 4cm/kanan 3cm/bawah 3cm, halaman judul lengkap, TTD kata pengantar dua kolom, footnote skripsi-grade, daftar pustaka hanging indent.
- Elsevier: sitasi numeric ter-render (0 `[?]`), abstrak + keywords muncul, tabel tidak overflow (gunakan `tabularx`/`\textwidth` bila perlu), class `elsarticle` preprint 1 kolom.
- Detail checklist: lihat file format masing-masing.

### 8. Optimasi PDF (jika > 3 MB)

Penyebab 99% ukuran = cover PNG yang mengembang saat di-embed. Strategi S1 = resize cover ke 2000 px + JPG q85, ganti referensi `\includegraphics`, compile ulang penuh, verifikasi halaman/kata/sitasi identik. S2/S3 butuh Ghostscript (biasanya tidak tersedia). S5 DILARANG tanpa izin eksplisit. Jangan commit/rollback otomatis — biarkan working tree + `.bak` utuh, laporkan opsi (a) COMMIT (b) ROLLBACK (c) TERIMA+S5.

### 9. Commit

Hapus `*.bak` sebelum commit; jangan commit artefak (`*.aux/.log/.bbl/.blg/.out/.spl/.toc`) kecuali diminta. Konvensi pesan: `feat:`/`fix:`/`docs:`/`perf:`/`chore:`. Tag: `paper-v1.0` untuk rilis paper; jangan geser `v1.0-prd`/`template-v2.0`. Eksekusi commit+tag HANYA setelah user setuju.

## References

| File | Isi |
|---|---|
| `references/format-ieee.md` | Aturan 2 kolom, sitasi numeric, abstrak & index terms, troubleshooting IEEE |
| `references/format-makalah-uin.md` | Aturan 1 kolom, footnote skripsi-grade, halaman judul, TTD kata pengantar, troubleshooting |
| `references/format-elsevier.md` | Aturan 1 kolom elsarticle, preprint style, sitasi numeric |
| `references/prompt-library.md` | Prompt siap pakai (paper baru, update, optimasi, verifikasi, troubleshooting, commit, audit) |
| `references/workflow-full.md` | SOP end-to-end lengkap |
| `references/troubleshooting.md` | Katalog error LaTeX umum + solusi |

Baca file reference yang relevan sebelum mengerjakan task — jangan mengandalkan ingatan untuk aturan format.

## Scripts

`scripts/` berisi copy dari `template-makalah/build-*.ps1`:

| Script | Fungsi |
|---|---|
| `build-all.ps1` | Build JILID + SOFTFILE sekaligus |
| `build-jilid.ps1` | Build versi jilid (twoside, margin mirror) → `MAKALAH_JILID.pdf` |
| `build-softfile.ps1` | Build versi softfile (oneside, margin simetris) → `MAKALAH_SOFTFILE.pdf` |

Untuk IEEE pakai `assets/template-ieee/build.ps1` (4-pass dengan bibtex). Untuk Elsevier pakai `assets/template-elsevier/build.ps1` (4-pass dengan bibtex).

## Assets

| Folder | Isi |
|---|---|
| `assets/template-ieee/` | Template artikel IEEE (2 kolom). File kunci: `template_ieee.tex`, `referensi_template.bib`, `build.ps1`, `clean.ps1`, `Makefile` |
| `assets/template-makalah/` | Template makalah UIN (1 kolom). File kunci: `template-makalah.tex`, `template-makalah-softfile.tex`, `halaman-judul.tex`, `kp.tex`, `bab1–3.tex`, `pustaka.tex` |
| `assets/template-elsevier/` | Template Elsevier (1 kolom, `elsarticle`, style `elsarticle-num`). File kunci: `template_elsevier.tex`, `referensi_template.bib`, `build.ps1` |

Catatan: `*.pdf`, `*.aux`, `*.log`, `*.bak*`, `.git/` sengaja TIDAK ikut (reproducible via build script).
