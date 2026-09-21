# Personal Intelligence Audit — 2026-09-21

Hasil inventory `product/apps/api/services/rps-batch/` (config.js, orchestrator.js, generator.js).

## 1. Inventory Config

**DEFAULTS (26 keys):** template, bahasa, humanize_level, min_references, sections,
batch_root, max_retries, use_secondbrain, use_crossref, formality, citation_style,
length_target, paraphrase_tier, plagiarism_check, mode, title_mode, title_style,
title_custom, authors, author_style, dosen, kelas, preset_source, style_preset_id,
auto_template.

**ENUMS (12 keys):** template, bahasa, humanize_level, formality, citation_style,
length_target, paraphrase_tier, plagiarism_check, mode, title_mode, title_style,
preset_source.

**Applier existing:** TIDAK ADA. Folder `personalize/` belum ada.
Orchestrator tidak memanggil applyFormality / applyCitation / enforceLength /
enforceAuthorStyle / applyParaphrase / applyHumanizer / preflight (grep = 0 hit).

**Usage di generator.js:**
- `formality`, `citation_style`, `length_target`, `author_style.keywords/banned_words`
  dipakai sebagai **prompt hint** via `styleHint()` (bukan post-process strict).
- `bahasa` dipakai via `langOf()` (id/en) — strict di heading/spec.
- `paraphrase_tier` + `humanize_level` dipakai **strict per-section** via
  `applyParaphrase()` + `applyHumanizer()` (proper, bukan hint).
- `tone / perspective / audience / density` = TIDAK dipakai sama sekali.

## 2. 12 Dimensi Personalisasi

| # | Dimensi | Enum/Options | Config Field | Prompt Hint | Post-Process | Auto-Detect | Status |
|---|---|---|---|---|---|---|---|
| 1 | **Bahasa** | id, en (+ id-formal, id-semi, en-academic, mix di API) | bahasa | ✅ | ❌ | ❌ | ⚠️ |
| 2 | **Formality** | formal, semi-formal, santai | formality | ✅ | ❌ | ❌ | ⚠️ |
| 3 | **Tone** | akademik, jurnalistik, populer, reflektif, kritis | tone | ❌ | ❌ | ❌ | 🔴 BARU |
| 4 | **Perspective** | first, third, mixed, objective | perspective | ❌ | ❌ | ❌ | 🔴 BARU |
| 5 | **Target Audience** | mahasiswa, dosen, peneliti, umum, institusi | audience | ❌ | ❌ | ❌ | 🔴 BARU |
| 6 | **Citation Style** | APA, IEEE, MLA, Chicago, Harvard, Vancouver (+ footnote legacy) | citation_style | ⚠️ | ⚠️ refs | ⚠️ | ⚠️ |
| 7 | **Length Target** | pendek, sedang, panjang (+ kustom via sections) | length_target | ✅ tokens | ❌ | ❌ | ⚠️ |
| 8 | **Template** | ieee, uin, elsevier, makalah, log-mingguan | template | ❌ | ✅ latex.js | ✅ keyword | ✅ |
| 9 | **Paraphrase Tier** | T1-T7, T1-Lit, none | paraphrase_tier | ⚠️ | ✅ | ❌ | ✅ |
| 10 | **Humanize Level** | H1-H5, none | humanize_level | ❌ | ✅ | ❌ | ✅ |
| 11 | **Author Style** | keywords[], bannedWords[], signature | author_style | ⚠️ | ❌ | ❌ | ⚠️ |
| 12 | **Plagiarism Check** | off, internal, external (+ eksternal legacy) | plagiarism_check | ❌ | ⚠️ audit | ❌ | ⚠️ |

## 3. Dimensi Tambahan (Meta)

| # | Dimensi | Enum | Config Field | Status |
|---|---|---|---|---|
| 13 | **Gaya Argumentasi** | deduktif, induktif, dialektis, naratif | argument_style | 🔴 BARU |
| 14 | **Densitas Sitasi** | sparse, sedang, dense | citation_density | 🔴 BARU |
| 15 | **Visual Preference** | text-heavy, table-heavy, figure-heavy, balanced | visual_preference | 🔴 BARU |
| 16 | **Struktur Output** | linear, hierarkis, qa, mind-map | output_structure | 🔴 BARU |
| 17 | **Naming Convention** | kebab, snake, camel, TitleCase, lowercase | naming_convention | 🔴 BARU |
| 18 | **Output Format** | pdf, docx, md, tex, all | output_format | 🔴 BARU |

## 4. Gap Priority

- 🔴 **P0 (BARU):** Tone, Perspective, Audience, Gaya Argumentasi, Densitas Sitasi,
  Visual Preference, Struktur Output, Naming Convention, Output Format
  (9 field baru di config + auto-detect rules + appliers).
- 🟡 **P1 (fix):** Formality applier, Citation applier, Length enforcer,
  Author style enforcer (saat ini prompt-hint saja).
- 🟢 **P2 (sudah OK):** Template (latex.js + autoDetectTemplate),
  Paraphrase (per-section proper), Humanize (per-section proper),
  Auto-detect template keyword.

## 5. Insight

**Sistem personalisasi butuh 18 dimensi** untuk benar-benar memahami user.
Saat ini baru 4 yang strict-applied (template, paraphrase, humanize, auto-detect template).
14 dimensi lain masih prompt hint atau belum ada.

Rencana: extend config ENUMS+DEFAULTS (9 baru) → autoDetect.js (rules 12+ dimensi)
→ preflight.js (merge priority override > config > auto > default, WAJIB sebelum task)
→ 6 applier baru (tone, perspective, audience, argumentStyle, citationDensity,
visualPreference) → integrasi orchestrator + /makalah + /rps-batch + AGENTS.md.
