# AGENTS.md — Konteks Proyek untuk OpenCode

> File ini dibaca otomatis oleh OpenCode saat startup.
> Update setiap sesi berakhir.

## Status Proyek (2026-09-19)

**Versi terakhir:** v11.9 (deploy fix + integrations + second brain) — LIVE PRODUCTION 2026-09-19
(API `5928ea3e` Online + Web READY `dpl_ACnCuwFCcpxYiDsApAHAF25VLuT2`; tag `parafrase-tiers-v11.9`)
**Fase aktif:** Production Live (PG) + Onboarding 10 user pertama

### Status Produksi (2026-09-19)

**Web:** https://web-taupe-pi-wnuhhjhh6s.vercel.app (Vercel)
**API:** https://api2-production-1203.up.railway.app (Railway, deploy via `railway up` — TIDAK ada auto-deploy GitHub)
**DB:** PostgreSQL Neon (`DB_DRIVER=pg`) — SQLite volume `api2-volume` nonaktif (data seed+smoke dimigrasi 2026-09-19)
**Health:** {"status":"ok","db":{"status":"ok"}} (latency ~1-2s = Neon)

### Tech Debt Aktif (WAJIB sebelum scale >20 user)

1. ~~**DB_DRIVER masih sqlite**~~ — SELESAI 2026-09-19 (2G): semua route via pg-adapter async, production `DB_DRIVER=pg`.

2. ~~**Backup Neon manual**~~ — SELESAI 2026-09-19: workflow `backup-prod-neon`
   cron harian aktif + terverifikasi success (run `35442405623`), branch `backup-20260919` ready.

3. **Better-sqlite3 pinned ^12.2.0** — v13 SEGFAULT di Railway runtime.
   Update hati-hati; test SEGFAULT regression sebelum upgrade.

### 3 Bug Production yang Sudah Diperbaiki (f5106b4+)
- server.js bind 0.0.0.0 (bukan ::)
- better-sqlite3 pin v12 (SEGFAULT di v13)
- Deploy kode 2B-2F via `railway up` (tidak ada auto-deploy GitHub — push saja TIDAK deploy)

### Yang Sudah Selesai
- [x] Migrasi typing_stats ke Neon (011 PG / 015 sqlite, v11.8 TASK 0A — tabel ada, kosong)
- [x] Research/scraping (v11.8 FASE A): registry + circuit breaker, Firecrawl, Crawl4AI, Scrapling,
      MarkItDown+Chunkr, Scrapy+Crawlee, API `/research/*` (migrasi 012 PG / 016 sqlite), halaman Research, command `/research`
- [x] UI ekstra (v11.8 FASE B): Sonner toast, Cmdk Ctrl+K, DnD-kit reorder bab, Number-flow,
      Input-OTP (`/verify-email`), React-virtuoso, Recharts activity chart, `/ui-showcase` (dev only)
- [x] Stack options docs (v11.8 FASE C): `docs/stack-options/` (backend/DB/frontend/state) + stub migrasi (go/mysql/astro)
- [x] Foundation + AI guides update (v11.8 FASE D): zod/tanstack-query/prisma docs, Tools Integration di 13 AI guides
- [x] Tooling parafrase tier (v1-v3)
- [x] RISE 1-6 produk (v4-v6)
- [x] Multi-user auth + CRDT (v7-v8)
- [x] Deploy kit + AI + Open Source (v9)
- [x] PWA + Mendeley/Zotero + Multi-tenant (v10)
- [x] SSO + Billing scaffold (v10.4, mock mode)
- [x] Deploy kit lokal (v11.0)
- [x] Neon DB setup + migrasi (6 file applied)
- [x] .env.production dibuat (di Default Project)
- [x] Switch production ke PostgreSQL (2G): migrasi data + `DB_DRIVER=pg` + E2E pass

### Yang Sedang Dikerjakan
- [x] Deploy API ke Railway — **LIVE 2026-09-18** (ganti Fly.io, no CC)
  - URL: `https://api2-production-1203.up.railway.app` (service `api2`, region sfo)
  - DB: SQLite di Railway volume `api2-volume` (`/app/data`, 500MB) — Neon PG BELUM dipakai
  - Fix penting: `server.js` bind `0.0.0.0` (bukan default `::`), `better-sqlite3` pin `^12.2.0`
    (v13.0.3 SEGFAULT di runtime Railway), base image `node:20-bookworm-slim` (bukan alpine)
  - Diverifikasi: /health ok, register 201, login 200, GET /papers 200, CORS Vercel ok
- [x] Deploy Web ke Vercel — **LIVE 2026-09-18**
  - URL: `https://web-taupe-pi-wnuhhjhh6s.vercel.app`
- [x] Deploy v11.8 ke production — **LIVE 2026-09-19**
  - API: `railway up` detach → deployment `898e223f` Online; /health ok (db ok),
    register 201 → login 200 → `/research/adapters` 200 (5 adapter + circuit fields) → GET /papers 200
  - Web: `vercel --prod --yes` → READY, alias `web-taupe-pi-wnuhhjhh6s` (200, 0.9s);
    bundle berisi cmdk + sonner + number-flow + input-otp + research
    (catatan: deploy pertama tanpa `--yes` gagal "Not authorized" — retry dengan `--yes` OK)
  - Live di prod: Cmd+K palette + Sonner toast (global), /research, /verify-email (OTP), AnimatedNumber
  - Dev-only (tree-shaken dari bundle prod, by design): /ui-showcase, DnD reorder bab,
    VirtualList, ActivityChart — hanya dipakai UIShowcase.jsx (gate `import.meta.env.DEV`)
  - Follow-up v11.9 SELESAI: ChapterTreeDnD + VirtualList + ActivityChart live di halaman prod
    (PaperEditor), /dev/showcase opt-in via VITE_ENABLE_SHOWCASE, vercel.json rewrite → Railway
- [x] Integration guides (v11.9 FASE B): `integrations/` — 15 file (secondbrain, notion, obsidian,
      hermes, youtube, zotero, mendeley, browser-use, notebooklm, logseq, roam, perplexity, openrouter, 9router)
- [x] Second Brain integration (v11.9 FASE C): import wiki → Ceritas, export paper → raw/,
      RAG proxy /ask-rag, halaman SecondBrain + command `/secondbrain` (lokal-first, opt-in)
- [x] Deploy v11.9 ke production — **LIVE 2026-09-19**
  - API: `railway up --service api2 --detach` → deployment `5928ea3e` SUCCESS + Online;
    /health ok (db ok, latency ~1.2-1.9s = Neon; `DB_DRIVER=pg`);
    secondbrain `{"enabled":false,"pathExists":false}` (opt-in lokal-first, by design — butuh `SECONDBRAIN_ENABLED=true` bila diaktifkan)
  - Web: `vercel --prod --yes` → READY `dpl_ACnCuwFCcpxYiDsApAHAF25VLuT2`, alias `web-taupe-pi-wnuhhjhh6s`;
    1307 modules, build cache hit
  - Rewrite `/api/*` → Railway: 200 ✅ (`/api/health` kembalikan JSON health API)
  - Live di prod: ChapterTreeDnD (PaperEditor), ActivityChart (PaperEditor),
    SecondBrainPanel + `/org/:slug/secondbrain` (+ flat `/secondbrain` legacy)
  - `VITE_ENABLE_SHOWCASE=1` ditambah ke env Preview (bukan Production) → `/dev/showcase` aktif di preview deploy
  - Catatan CLI: `railway status --service X` TIDAK didukung (railway 5.57.9) — pakai `railway status` saja
    (service `api2` sudah linked); `railway up --service api2 --detach` tetap valid
- [ ] Onboarding 10 user pertama
- [ ] (Follow-up) Backup Neon otomatis + monitoring (3A-3B)
- [x] Cleanup TASK 1 PostHog — DONE 2026-09-19: key rotated user, Vercel Production env
  (`VITE_ANALYTICS_PROVIDER=posthog`, `VITE_POSTHOG_KEY`, `VITE_POSTHOG_HOST=https://us.i.posthog.com`),
  redeploy `dpl_3jtk3K91yWp3zDC2Dx4y4jKc7A5u` READY (alias 200, API health ok)

### Blocker Aktif
1. **Fly.io** → RESOLVED via Railway (Jalur B). Tidak perlu CC.
2. **Tech debt scale** → backup manual + better-sqlite3 pin (lihat Tech Debt Aktif di atas).

## Langkah Berikutnya (Prioritas)

### 1. Onboarding 10 user pertama (BISA SEKARANG — production live)
- Sebar URL Web: https://web-taupe-pi-wnuhhjhh6s.vercel.app
- Smoke test end-to-end: register → login → CRUD papers
- Kumpulkan feedback

### 2. Tech Debt sebelum scale >20 user
- Setup backup Neon otomatis (cron branch harian)
- Test SEGFAULT regression sebelum upgrade better-sqlite3 v13

### 3. (Arsip) Deploy — SUDAH LIVE 2026-09-18
- Web → Vercel: DONE
- API → Railway (Jalur B): DONE — Fly.io tidak perlu CC

## Lokasi File Penting
- `.env.production` — kredensial production (git-ignored)
- `product/apps/api/` — backend (Express + PostgreSQL)
- `product/apps/web/` — frontend (Vite + React + PWA)
- `product/apps/api/fly.toml` — config Fly.io
- `product/apps/web/vercel.json` — config Vercel
- `product/scripts/` — script deploy + smoke test

## Neon DB
- Project ID: `hidden-smoke-17016924`
- Region: `ap-southeast-1` (Singapore)
- Connect via: `neonctl connection-string --project-id "hidden-smoke-17016924" --pooled`

## Cleanup Status (v11.9 — 2026-09-19)

✅ Task 1 — PostHog: key rotated + Vercel env (redeploy `dpl_3jtk3K91yWp3zDC2Dx4y4jKc7A5u`)
✅ Task 2 — Sentry: DONE 2026-09-19: DSN production terpisah (API `makalah-ceritas` di Railway
  `SENTRY_DSN`, Web `makalah-ceritas-web` di Vercel Production `VITE_SENTRY_DSN` --type config);
  Railway log `[sentry] error tracking aktif`, redeploy API (health 200) + Web `dpl_3QAWVuzAKtEDYrQXtNjeBHoWCQUU` READY (alias 200)
✅ Task 3 — Neon backup: workflow `backup-prod-neon` aktif + success terverifikasi (run `35442405623`)
⏸️ Task 4 — WakaTime: panduan manual (client-side, tanpa commit)

Catatan penting:
- Neon default branch = `production` (BUKAN `main`)
- Backup workflow pakai `--parent production`, idempotent (re-run hari sama = skip)
- Retention: 7 hari (otomatis, jq try-catch tahan format array/object)

Pending remaining:
- design.md + prd.md versi user
- Onboarding 10 user pertama

## Kontak / Akun
- GitHub: `whoolm` (whoolm19872@gmail.com)
- Fly.io: `whoolm19872@gmail.com` (butuh CC)
- Vercel: `whoolm` (login GitHub)
- Neon: `whoolm19872@gmail.com` (login GitHub)

## Perintah OpenCode Tersedia
- `/status` — cek posisi
- `/deploy` — deploy API (kalau CC siap)
- `/sso-billing` — scaffold SSO + billing (sudah selesai)
- `/llm-finetune` — LLM fine-tune (repo terpisah)
- `/menu` — semua opsi
- `/makalah` — buat makalah: pilih gaya interaktif → paper dibuat via API
- `/preset` — kelola preset gaya (CRUD + default + apply)
- `/gaya` — ubah cepat 1 dimensi gaya paper
- `/plagiasi` — cek plagiasi paper (internal/eksternal)
- `/humanize` — humanisasi bab H1-H5 (butuh deploy v11.6)
- `/aicheck` — deteksi skor AI + rekomendasi H (butuh deploy v11.6)
- `/research` — scraping riset (scrape URL, convert doc, batch, history)
- `/secondbrain` — Second Brain: status, browse wiki, ask RAG, import/export (butuh `SECONDBRAIN_ENABLED=true`)
- Integrasi: `integrations/` (secondbrain, notion, obsidian, hermes, youtube, zotero, mendeley,
  browser-use, notebooklm, logseq, roam, perplexity, openrouter, 9router)

---

## Project Identity (memory integration 2026-09-20)
- Nama: Makalah Ceritas
- Jenis: Platform penulisan akademik all-in-one (Indonesia-first)
- Target: Mahasiswa, dosen, peneliti, institusi
- Status: Production live (v12.0)

## Repo & Lokasi
| Repo | Path | Isi |
|---|---|---|
| Default Project | C:\Users\USER\Documents\Default Project | Kode produk (API, Web, RPS batch, LLM) |
| makalah-ceritas-public | C:\Users\USER\Documents\makalah-ceritas-public | Docs + tier parafrase + 7-chat |
| makalah-ceritas-llm | C:\Users\USER\Documents\makalah-ceritas-llm | LLM fine-tune scaffold |
| SecondBrain | D:\SecondBrain | LLM Wiki (RAG, Chroma, 26k transcripts) |
| Ceritas-Batch | D:\Ceritas-Batch | RPS batch runtime (gitignored) |

## Production URLs
- Web:   https://web-taupe-pi-wnuhhjhh6s.vercel.app
- API:   https://api2-production-1203.up.railway.app
- DB:    Neon PostgreSQL (Singapore, branch `production`)
- Sentry: https://sentry.io/organizations/whoolm/issues/
- PostHog: https://us.posthog.com/project/617275
- Neon:  https://console.neon.tech
- GitHub: github.com/whoolm/Default-Project

## Deploy Notes
- Railway TIDAK auto-deploy → `railway up --service api2` manual
- Vercel auto-deploy dari GitHub
- Neon default branch = `production` (BUKAN `main`)
- Semantic-release aktif → Conventional Commits WAJIB

## LLM Provider Status (v12.0)
| Provider | Status | Model |
|---|---|---|
| Gemini | ✅ Primary | gemini-3.5-flash (quota 20/hari/model) |
| Groq | ✅ Primary | qwen/qwen3.8-27b (WORKING), gpt-oss-20b (BROKEN) |
| OpenRouter | ⏸️ Slot ready | qwen/qwen3.8-27b:free |
| Ollama | ⏸️ Fallback | qwen2.5:7b (localhost:11434) |
| Zen | ❌ Disabled | free tier blocked via REST |

## OpenCode Commands
- `/makalah`, `/preset`, `/gaya`, `/plagiasi`, `/humanize`, `/aicheck`
- `/secondbrain`, `/rps-batch`, `/menu`, `/status`, `/setup`, `/llm`
- `/preflight` — personalisasi pre-flight (WAJIB sebelum task/project)

## Personalization Preflight (WAJIB — TASK E)

Setiap eksekusi task/project HARUS melalui preflight:

```
preflight({
  matkulId: '<01-04>',
  matkul: '<nama matkul>',
  jenis_tugas: '<makalah|log|esai|...>',
  topik: '<topik>',
})
```

Output: config 18 dimensi siap dipakai
(priority: userOverride > flags/config.md > auto-detect > default).

- Command: `/preflight` untuk manual (`.opencode/command/preflight.md`).
- Module: `product/apps/api/services/rps-batch/personalize/preflight.js`.
- Auto-detect: `personalize/autoDetect.js` (12+ dimensi via keyword rules).
- Appliers: `personalize/{tone,perspective,audience,argumentStyle}.js` (LLM,
  no-op bila default) + `personalize/{citationDensity,visualPreference}.js`
  (verify-only). Orchestrator `runGenerate()` memanggil preflight otomatis.
- Docs: `docs/PERSONAL-INTELLIGENCE.md` (lengkap) +
  `docs/PERSONAL-INTELLIGENCE-AUDIT.md` (audit 18 dimensi).

## Tech Debt & Known Issues
- Groq `openai/gpt-oss-20b` = reasoning model → output KOSONG (pakai qwen)
- .env.production punya DUPLIKAT GROQ_MODEL (perlu dibersihkan)
- Plagiarism internal = skipped (butuh org DB)
- Template `uin` fallback ke IEEE
- SQLite legacy masih ada (production sudah PG)

## Template per Matkul (klarifikasi 2026-09-21)

Setiap matkul punya template berbeda. JANGAN samakan:

| Matkul | Template | Karakteristik |
|---|---|---|
| PIH (01) | IEEE | 2-kolom, cover image, 4000+ kata, 30-50 refs |
| Ulumul Hadis (02) | Makalah | 1-kolom, 7 bagian (Judul, Kata Pengantar, Pendahuluan, Pembahasan, Analisis, Kesimpulan, Daftar Pustaka) |
| Moderasi (03) | Makalah | Sama seperti Ulumul Hadis |

Template "makalah" BUKAN versi sederhana IEEE — format berbeda sesuai
permintaan dosen Ulumul Hadis (Dr. Abdul Fatah Idris). Di config nilainya
`template: uin` (= makalah/narrative 1-kolom).

### Config di `D:\Ceritas-Batch\config.md`
```yaml
overrides:
  01: {template: ieee, ...}
  02: {template: uin, sections: [judul, kata_pengantar, pendahuluan_latar_belakang, pendahuluan_pokok_masalah, pembahasan_pengertian, pembahasan_pentingnya, pembahasan_utama, analisis, kesimpulan, daftar_pustaka]}
  03: {template: uin, humanize_level: H2}
```

## JANGAN Sentuh
- `fix-skill.md` (untracked pre-existing)
- `.env*` files (gitignored, secret)

## Deferred (2026-09-20 — dicatat, dikerjakan nanti)

### ⏸️ BESOK (2026-09-21)
- **C: Regen matkul-02/03** — tunggu quota LLM reset
  - `/rps-batch generate --matkul 02` (Ulumul Hadis)
  - `/rps-batch generate --matkul 03` (Moderasi)
  - Regen topik-05 juga (untuk LLM full)

### 🚨 SECURITY PENDING
- Rotate 5 API keys: PostHog, Gemini, Groq, OpenRouter, Zen
- Ref: `docs/SECURITY-TODO.md`

### 📌 INTEGRATION ROADMAP (Opsi D follow-up)
- P1: openrouter, 9router, perplexity
- P2: notion, obsidian, hermes, browser-use, logseq, roam, youtube
- Last: notebooklm

### 🔮 FUTURE
- Second Brain (SKIP sementara — trigger setelah matkul-02/03 selesai)
- Billing production
- Scraping integration
- Onboarding 10 user
- design.md + prd.md versi user

## Memory System

- Lokasi: `.memory/`
- Module: `product/apps/api/services/memory/`
- Commands: `/memory`, `/log`, `/progress`, `/next`, `/end-session`
- Schema: `docs/MEMORY-SCHEMA.md`

### Aturan WAJIB
1. Setiap task selesai → `/log done <task-id>`
2. Setiap sesi berakhir → `/end-session`
3. Sebelum mulai task baru → `/next` (cek rekomendasi)
4. Blocked → `/log block <task-id> --blocker "..."`
