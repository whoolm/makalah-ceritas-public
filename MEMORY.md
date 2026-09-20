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

## Next Steps (kalau lanjut)
1. Bersihkan .env.production (hapus duplikat GROQ_MODEL)
2. Fix Groq model → qwen/qwen3.8-27b
3. Resume RPS batch
4. Rotate API keys (security)
5. Onboarding 10 user pertama
6. design.md + prd.md versi user
