# Makalah Template Audit — 2026-09-21

## Metode
- Baca `product/apps/api/services/rps-batch/templates/makalah-paper.js` (118 baris)
- Baca `product/apps/api/services/rps-batch/latex.js` (dispatcher `exportLatex`)
- Baca `product/apps/api/services/rps-batch/orchestrator.js` (`authorsFromConfig`, `makeHandler`)
- Inspeksi output aktual `D:\Ceritas-Batch\output\matkul-02/topik-04/paper.tex` + `meta.json`
- Inspeksi output aktual `D:\Ceritas-Batch\output\matkul-03/topik-04/paper.tex` + `meta.json`
- Inspeksi `D:\Ceritas-Batch\config.md` overrides 02/03

## Temuan vs asumsi task

| Asumsi task | Hasil audit |
|---|---|
| `template: makalah` render seperti IEEE (`IEEEtran`, `abstract`, `Index Terms`) | **TIDAK TERBUKTI.** Output 02 & 03 diawali `\documentclass[a4paper,12pt]{article}`. Tidak ada `IEEEtran`/`IEEEkeywords` di paper.tex. |
| `makalah` tidak di-handle dispatcher → fallback IEEE | **TIDAK TERBUKTI.** `latex.js:106` menangani `tpl === "makalah"` via `renderMakalahPaper`. Unknown template sudah throw (`latex.js:85-86`). |
| Export `renderMakalahLatex` | Salah nama. Export aktual: `renderMakalahPaper(paper, chaptersLatex, opts)` — kontrak array chapters, bukan `sections`/`references` dict. Rewrite spek task (`renderMakalahLatex` + `opts.sections`) **tidak kompatibel** dengan caller. |
| Author hardcoded "Tim RPS" | **TIDAK TERBUKTI.** `orchestrator.js:45-59,146-160` pass `authors` dari config. `meta.json` 02/03: 2 authors + NIM; `paper.tex` tampil dua nama + dosen pengampu. "Tim RPS" hanya fallback bila config tanpa authors. |
| Config 02/03 salah (`template: uin`) | **TIDAK TERBUKTI.** Keduanya sudah `template: makalah` dengan dosen + sections terisi. |

## Bug nyata yang ditemukan (1)

**`template: uin` dipetakan ke IEEE, seharusnya ke makalah.**
- `latex.js:84`: `note = "template uin belum tersedia — render IEEE sebagai pengganti"`, lalu
  jatuh ke jalur `renderIEEE` umum (bukan cabang makalah).
- `AGENTS.md` menyatakan `template: uin` = makalah/narrative 1-kolom.
- `config.js:96` masih mengizinkan enum `uin`, jadi user yang ikut docs lama
  diam-diam dapat output IEEE 2-kolom. Ini satu-satunya silent-fallback nyata.

## Kesenjangan non-bug (by design, bukan fallback)

- Template makalah = `article` + `\section` + `\maketitle` + `\bibliography{refs}`,
  **bukan** `report` + `\chapter*{BAB I/II/III}` + `titlepage` cover + `enumerate`
  DAFTAR PUSTAKA seperti referensi `MAKALAH ULUMUL HADIS.pdf` (file referensi
  tidak ditemukan di repo maupun `D:\Ceritas-Batch`, jadi tidak bisa diverifikasi).
- Struktur BAB/cover adalah permintaan fitur, bukan bug dispatcher.

## Action (arah A — minimal fix, disetujui user 2026-09-21)

1. `latex.js`: alias `uin` → renderer makalah (note diperbarui). Tidak ada lagi
   fallback diam-diam `uin` → IEEE.
2. `templates/makalah-paper.js`: tambah cover `titlepage` **opt-in**
   (`opts.coverPage`, default `false` → output default tidak berubah).
3. `latex.js` cabang makalah: teruskan `coverPage`/`coverFile` (sebelumnya diabaikan).
4. Baru `services/rps-batch/validateOutput.js`: `validateLatex(tex, template)`
   murni; dipakai warn-only di cabang makalah (tidak throw agar pipeline lama aman).
5. Tidak ada regen M4 (kuota LLM + output existing sudah benar secara struktur).

## Verifikasi yang dilakukan
- `node -e` render makalah default (tanpa cover) → article, ada Kata Pengantar,
  tanpa IEEEtran/abstract/Index Terms.
- `node -e` render makalah `coverPage:true` → ada `\begin{titlepage}`.
- `node -e` `exportLatex({template:'uin'})` → tex article (bukan IEEEtran),
  note berisi penanda alias.
- `node -e` `validateLatex(tex,'makalah')` → valid:true pada output article;
  invalid terdeteksi pada fixture IEEEtran.
