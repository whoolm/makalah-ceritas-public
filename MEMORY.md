# MEMORY — Makalah Ceritas Project Context

> **Auto-load:** File ini untuk referensi konteks.
> Untuk konteks teknis, lihat `AGENTS.md`.

## Perjalanan Versi
C1-C7 (desain) → v1-v3 (tooling) →
v4-v6 (single-user) →
v7-v8 (multi-user) → v9 (deploy+AI+open-source) →
v10 (PWA+integrations+multi-tenant) → v11 (deploy prod + integrations) →
v12 (RPS batch)

## Fitur Utama (Summary)
- RISE 1-6: paper lifecycle (paper→research→content→QA→export→collab)
- 7 Tier Parafrase: T1-T7 + T1-Lit + density ceiling
- AI Features: outline, paraphrase, coherence, summary, humanizer H1-H5
- Multi-tenant: orgs + roles + isolation
- SecondBrain RAG: import wiki + export paper + ask-rag

## Integrations (15+)
Active: PostHog, Sentry, Neon backup, SecondBrain RAG, CrossRef, OAuth
Ready slots: OpenRouter, Mendeley, Zotero, Notion, Obsidian, Hermes, browser-use

## Docs Reference
- AGENTS.md — konteks proyek (auto-read)
- design-default.md + prd-default.md — design + PRD
- ai-guides/ — 12 AI-specific guides
- docs/foundation/ — 8 foundation docs
- docs/stack-options/ — 5 stack alternatives
- docs/prd/ — detail per fitur
- docs/prosedur/ — cara pakai per fitur
- integrations/ — 15 service guides
- AUDIT_TRAIL.md — rekonsiliasi klaim vs realita
- CHANGELOG.md — riwayat versi

## RPS Batch Status (SKIP DULU)
- ✅ M4 prioritas 3 matkul — DONE
- ✅ matkul-01 full 14/14 — DONE
- ⏳ matkul-02 — in progress
- ⏳ matkul-03 — pending
- 🚫 Blocker: Groq gpt-oss-20b empty + .env duplikat

## Pending Integration
- Second Brain: ⏸️ SKIP — services/secondbrain/{reader,writer,rag-client}.js + routes/integrations/secondbrain.js exist; env SECONDBRAIN_ENABLED=true (lokal); future RAG /ask-rag → enrich reference, export paper → raw/; trigger setelah matkul-02/03 selesai

## Next Steps (kalau lanjut)
1. Bersihkan .env.production (hapus duplikat GROQ_MODEL)
2. Fix Groq model → qwen/qwen3-32b
3. Resume RPS batch
4. Rotate API keys (security)
5. Onboarding 10 user pertama
6. design.md + prd.md versi user

## Status Terkini (2026-09-20)

### ✅ SELESAI HARI INI
| Task | Commit | Status |
|---|---|---|
| Fase 1 Audit | docs/AUDIT-INTEGRATION.md | ✅ |
| Fase 2 Title Generator | 34fcb31 | ✅ |
| Fase 3 Style Preset DB | 95faef6 | ✅ |
| Fase 4 Paraphrase + Humanizer | aeccdb2 | ✅ |
| H-B Cleanup + SB Doc | 8573103 | ✅ |
| H-C Coherence Wiring | 45c702d | ✅ |
| Fase 7 Gap Report | 1c8ded5 | ✅ |
| Opsi B P1 Gaps Fix | 0416fe8, dc74996, e279105 | ✅ |
| Opsi D 11 Integrations | c367f77 | ✅ |
| PIH FINAL v4 Generator | 8a76151 | ✅ |
| LaTeX PIH v4 Polish | 8a5d5cf | ✅ |

### 🔜 IMMEDIATE
- Commit 3 file polish (sedang running)
- Submit PIH FINAL ke dosen

### ⏸️ BESOK (2026-09-21)
- **C: Regen matkul-02/03**
  - `/rps-batch generate --matkul 02`
  - `/rps-batch generate --matkul 03`
  - Tunggu quota LLM reset
  - Regen topik-05 juga (untuk LLM full)

### 🚨 SECURITY PENDING
- Rotate 5 API keys (PostHog, Gemini, Groq, OpenRouter, Zen)

### 📊 MATKUL STATUS
| Matkul | Status |
|---|---|
| PIH (01) | ✅ FINAL v4 |
| Ulumul Hadis (02) | ⏸️ Regen besok |
| Moderasi (03) | ⏸️ Regen besok |

### 📌 INTEGRATION ROADMAP
- P1: openrouter, 9router, perplexity
- P2: notion, obsidian, hermes, browser-use, logseq, roam, youtube
- Last: notebooklm

### 🔮 FUTURE
- Second Brain (SKIP sementara)
- Billing production
- Scraping integration
- Onboarding 10 user

---

## Status Terkini (2026-09-21)

### ✅ SELESAI HARI INI
| Task | Commit | Status |
|---|---|---|
| PIH IEEE FINAL v5 | 9ee3f85, b912c26 | 4186 kata, 35 refs, 7 hal |
| Multi-key Gemini setup | 135b805 | Key #1 + #2 (auto-fallback on 429) |
| Cover + tabel single-column | ae855e5 | cover_pih.png + table_span |
| Fase 1-7 (audit, title, style DB, para+human, SB, gap report) | multi | ✅ |
| Opsi B (parsers + plagiarism + exporters) | 0416fe8, dc74996, e279105 | ✅ |
| Opsi D (11 integrations docs) | c367f77 | ✅ |
| Coherence wiring | 45c702d | ✅ |
| Memory final | 4492a5d | ✅ |

### 📌 KLARIFIKASI TEMPLATE PER MATKUL
⚠️ **PENTING:** Setiap matkul punya template berbeda:

| Matkul | Template | Format | Contoh |
|---|---|---|---|
| **PIH (01)** | **IEEE** | 2-kolom, cover image, ~4000-5000 kata, 30-50 refs | makalah_pancasila_ieee.tex |
| **Ulumul Hadis (02)** | **Makalah/Narrative** | 1-kolom, kerangka 7 bagian (Judul, Kata Pengantar, Pendahuluan, Pembahasan, Analisis, Kesimpulan, Daftar Pustaka), ~2000-3000 kata | template `uin` di config |
| **Moderasi (03)** | **Makalah/Narrative** | Sama seperti Ulumul Hadis | template `uin` di config |

**Catatan:** Template "makalah" BUKAN versi sederhana dari IEEE — itu
memang format berbeda yang diminta dosen Ulumul Hadis (Dr. Abdul Fatah Idris).
Di `D:\Ceritas-Batch\config.md` nilai config-nya adalah `template: uin`
(= template makalah/narrative 1-kolom).

### 📌 OUTPUT UNTUK USER (Manual Actions)
| Output | File/Lokasi | Status |
|---|---|---|
| PIH FINAL PDF | D:\Ceritas-Batch\submit\M4\01-PIH-Hukum-dan-Hak-IEEE-FINAL.pdf | ✅ Siap submit |
| Cover PIH | cover_pih.png (2480×3508 px @ 300 DPI) | ⏳ Generate manual |
| PPT PIH 10 slide | prompt sudah siap | ⏳ Run di OpenCode |
| NotebookLM 10 output | prompt sudah siap | ⏳ Manual di NotebookLM |
| Glosarium + Indeks | prompt ringkas siap | ⏳ Manual di NotebookLM |

### 📌 NOTEBOOKLM PROMPTS (Sudah Disiapkan)
User akan jalankan manual di notebooklm.google.com. 10 output:
1. Audio Overview (podcast 15 menit)
2. Slide PPT outline (12 slide)
3. Video Overview (5-7 menit)
4. Mind Map (hierarki 4 level)
5. Report (Study Guide 3-5 hal)
6. Flashcards (25 kartu)
7. Quiz (20 soal)
8. Infographic (1 hal)
9. Data Tables (3 tabel)
10. Glosarium + Indeks (40 entri + indeks asing/nama/UU)

### 📌 LLM PROVIDER STATUS (Updated 2026-09-21)
| Provider | Status | Model | Quota |
|---|---|---|---|
| Gemini #1 | ✅ Active | gemini-3.5-flash | 20 req/hari |
| Gemini #2 | ✅ Active | gemini-3.5-flash | 20 req/hari |
| **Total Gemini** | — | — | **40 req/hari** |
| Groq | ✅ Active | qwen/qwen3.8-27b | TPD (reset 07:00 WIB) |
| OpenRouter | ⏸️ Slot ready | qwen/qwen3.8-27b:free | — |
| Ollama | ⏸️ Local | qwen2.5:7b | — |
| Zen | ❌ Disabled | — | — |

**Multi-key rotation:** Auto-fallback on 429 (key #1 exhausted → key #2).

### ⏸️ BESOK (2026-09-22, setelah quota reset)
- Regen matkul-02 (Ulumul Hadis) — **template makalah/narrative** (`template: uin`), 10 sections custom (kerangka 7 bagian dosen)
- Regen matkul-03 (Moderasi) — template makalah/narrative (`template: uin`)
- Command: `/rps-batch generate --matkul 02` + `--matkul 03`

### 🚨 SECURITY PENDING
- Rotate 5 API keys: PostHog, Gemini #1, Gemini #2, Groq, Zen
- Update .env.production + Railway + Vercel + redeploy
