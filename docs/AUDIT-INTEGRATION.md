# Audit Integrasi — Default Project ↔ Ceritas-Batch

**Date:** 2026-09-20
**Focus:** Integrasi saja, tanpa regen.
**Scope:** `product/apps/api/services/` (Default Project) vs `product/apps/api/services/rps-batch/` (batch) + runtime `D:/Ceritas-Batch`.

## 1. Fitur Default Project (yang bisa diintegrasikan)

| # | Fitur | File | Sudah Dipakai di Batch? |
|---|---|---|---|
| 1 | Style Presets (DB) | `services/stylePresets.js` | ❌ Tidak — batch pakai `config.md` file |
| 2 | Paraphrase Tiers | `services/ai/paraphrase.js` (T1–T7 via LLM) | ⚠️ Label saja (`paraphrase_tier` di meta.json, service tak pernah dipanggil) |
| 3 | Plagiarism internal | `services/plagiarism/internal.js` (Jaccard 5-gram + cosine, pure function) | ❌ Skipped jujur (butuh korpus org/papers DB) |
| 4 | Humanizer H1–H5 | `services/humanizer/humanize.js` | ⚠️ H1–H3 lokal rule-based; H4/H5 tanpa LLM = skipped jujur |
| 5 | Author Style | `services/humanizer/style.js` (`applyAuthorStyle`) | ⚠️ Parsial — generator pakai `config.author_style` langsung via `styleHint()`, bukan service ini |
| 6 | LLM Registry | `services/llm/index.js` (groq→openrouter→gemini→ollama + cache) | ✅ Dipakai (`generator.js` 3 call site) |
| 7 | Template IEEE | `services/latex.js` + `rps-batch/templates/ieee-paper.js` | ✅ Native |
| 8 | Template UIN | — (belum ada di `services/templates/`) | ⚠️ Fallback → render IEEE + `note` di meta |
| 9 | Template Elsevier | `services/latex.js` (`renderElsevier`) | ⚠️ Ada renderer, narrative+footnote PIH hanya diuji di jalur IEEE |
| 10 | Title Generator | ❌ BELUM ADA | 🔴 **BARU (Fase 2)** |
| 11 | Citation Formatter | `services/bibtex.js` (`renderBibMulti`) | ⚠️ `.bib` saja; sitasi inline = `\cite{key}` dari LLM tanpa formatter |
| 12 | Web Style UI | `apps/web` StylePresets | ❌ Not used (tak ada bridge DB preset ↔ `config.md`) |
| 13 | SecondBrain RAG | `services/secondbrain/rag-client.js` | ⏸️ **SKIP** — wired lazy di `references.js`, tapi `use_secondbrain: false` untuk batch hukum/keislaman (by design) |

### Trace import cross-module (terverifikasi via `Select-String require(`)

| Modul batch | Require ke produk | Status |
|---|---|---|
| `generator.js` | `../llm` (×3: section, abstrak, keywords) | ✅ |
| `latex.js` | `../latex` (`renderIEEE`, `renderElsevier`, `mdToLatex`) | ✅ |
| `latex.js` | `./templates/ieee-paper.js`, `./references` | ✅ internal |
| `audit.js` | `../audit/tier`, `../humanizer/index`, `../humanizer/humanize` | ✅ |
| `references.js` | `../bibtex`, `../crossref`, `../secondbrain/rag-client` (lazy) | ✅/⏸️ |
| `ppt.js` | `../ppt` + `./latex` (`splitChapters`) | ✅ |
| `orchestrator.js` | hanya modul `./` internal (config, queue, references, generator, audit, latex, ppt, checklist) | ✅ wiring |
| — | `../stylePresets`, `../ai/paraphrase`, `../plagiarism/*`, `../humanizer/style` | ❌ tak ada yang require |

## 2. Gap Analysis

1. **Title Generator (🔴).** `generator.js:396-399` — `docTitle = section judul ?? topic.title` verbatim.
   Bukti: `D:/Ceritas-Batch/output/matkul-01/topik-04/paper.tex:23` → `\title{Hukum dan Hak}` (polosan).
2. **Style Preset vs config.md (🟡).** `stylePresets.js` = preset DB per-org/personal dengan ENUMS
   (`bahasa`, `formality`, `citationStyle`, `lengthTarget`, `plagiarismCheck`, `template`).
   Batch = YAML file (`formality`, `citation_style`, `length_target`, `paraphrase_tier`, `humanize_level`
   + `author_style`). Tak ada bridge dua arah; duplikasi semantik (`formality`/`citation_style`/`length_target` ada di keduanya).
3. **Paraphrase tier (🟡).** `paraphrase_tier: T1` hanya label di `meta.json`; `services/ai/paraphrase.js`
   (prompt builder + tier T1–T7) tak pernah dipanggil batch. Tier audit (`auditTier`) jalan, rewrite tier tidak.
4. **Plagiarism internal (🟢).** `checkPaper(text, corpus)` pure function — butuh korpus (papers org DB).
   Batch output file-based tanpa akses DB org → skip jujur tepat; integrasi butuh adapter korpus.
5. **Humanizer H4/H5 (🟢).** Tanpa LLM = skipped jujur (by design di `humanize.js`). PIH pakai H3 → tercakup.
6. **Template UIN native (🟢).** `latex.js:54` fallback eksplisit + note. PIH pakai `ieee` → tak terdampak.
7. **SecondBrain RAG (⏸️ future).** Noise filter (`RAG_NOISE_RE`) sudah ada di `references.js`;
   tetap OFF untuk hukum/keislaman (`use_secondbrain: false`). Jangan diaktifkan untuk PIH.

## 3. Prioritas Fix

1. 🔴 Title Generator (judul polosan) — **Fase 2 task ini**
2. 🟡 Style Preset integration (bridge DB ↔ file, satu arah dulu: export preset → `config.md`)
3. 🟡 Paraphrase tier apply proper (panggil `services/ai/paraphrase.js` pasca-humanize)
4. 🟢 Plagiarism internal (butuh adapter korpus org DB)
5. 🟢 Humanizer H4/H5 (butuh LLM aktif; fallback jujur sudah benar)
6. 🟢 Template UIN native
7. ⏸️ SecondBrain RAG (future, tetap OFF untuk PIH)

## 4. Rekomendasi (actionable)

- [x] (Fase 2) `services/rps-batch/titleGenerator.js` + `title_mode`/`title_style` di `config.js` + wiring `orchestrator.js`
- [ ] Bridge preset: `GET /style-presets/default` → render snippet YAML untuk ditempel ke `config.md` (tanpa DB write dari batch)
- [ ] Paraphrase: panggil `paraphrase(text, tier)` di `audit.js` setelah `humanize()` bila `paraphrase_tier` set dan LLM aktif
- [ ] Plagiarism: adapter korpus baca `output/**/paper.md` sebagai korpus lokal (tanpa DB) — skor internal antar-topik
- [ ] UIN template: port `templates/uin/paper.tex` ke `renderUIN()` di `services/latex.js` (mirip `renderElsevier`)

## Second Brain Integration (SKIP dulu, reminder)
- Status: ⏸️ SKIP
- Existing: services/secondbrain/{reader,writer,rag-client}.js + routes/integrations/secondbrain.js
- Env: SECONDBRAIN_ENABLED=true (lokal)
- Future: RAG /ask-rag → enrich reference, export paper → raw/, ceritas_synced.json
- Trigger: setelah matkul-02/03 selesai
