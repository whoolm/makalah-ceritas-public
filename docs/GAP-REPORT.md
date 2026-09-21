# GAP REPORT — FASE 7 Deep Audit Integrations

> Tanggal: 2026-09-20 · Scope: READ-ONLY (kecuali file ini) · Metode: scan `integrations/*.md`, `ai-guides/*.md`, `product/apps/api/services/*` vs `rps-batch/*.js`, `.opencode/command/*.md`, cross-check route + service code.

## Ringkasan

- Integrations audited: **15 file** (14 integration + 1 README katalog)
- AI guides audited: **14 file** (12 guide AI + README + _TEMPLATE)
- Service gaps (dirs tidak dipakai batch): **6 dari 11**
- Commands: **16 file** di `.opencode/command/` (singular, bukan `.opencode/commands`)
- Status integrations: **2 active, 1 partial, 11 planned**
- Status ai-guides: **0 planned/TODO** — semua guide lengkap v1.0 (~3.1–3.4 KB)

---

## 1. Table Status Integrations (15 file)

Sumber: baris `> **Status:**` tiap file + `integrations/README.md` legend (`active` = live prod, `partial` = endpoint/CLI ada UI menyusul, `planned` = panduan + kontrak API, belum implementasi).

| # | File | Status | Direction | Bukti kode |
|---|---|---|---|---|
| 1 | `secondbrain.md` | **partial** (v11.9 import/export/RAG lokal) | bidirectional | ✅ `routes/integrations/secondbrain.js`, `services/secondbrain/` (config, reader, writer, rag-client), `server.js:222-223` mount, `health.js:41-45` ringkasan |
| 2 | `zotero.md` | **active** (`POST /sync/zotero`, opt-in env) | import | ✅ `services/zotero.js`, `routes/sync.js:5-6` (`/sync/zotero/link`, `/collections`, `/import`) |
| 3 | `mendeley.md` | **active** (`POST /sync/mendeley`, opt-in env) | import | ✅ `services/mendeley.js`, `routes/sync.js:7` (`/sync/mendeley/link`, `/documents`) |
| 4 | `notion.md` | **planned** | bidirectional | ❌ tidak ada route/service notion di `product/apps/api` |
| 5 | `obsidian.md` | **planned** | bidirectional | ❌ tidak ada kode obsidian (vault file-based, hanya panduan) |
| 6 | `hermes.md` | **planned** | bidirectional | ❌ tidak ada kode hermes agent |
| 7 | `youtube.md` | **planned** | import | ❌ tidak ada YouTube transcript fetcher di API |
| 8 | `browser-use.md` | **planned** | import | ❌ tidak ada browser automation di API (dependensi jalur UI NotebookLM) |
| 9 | `notebooklm.md` | **planned** | import | ❌ grep `notebooklm` di `product/apps/api/**/*.js` = nol hit (lihat §4 case study) |
| 10 | `logseq.md` | **planned** | import | ❌ tidak ada kode logseq |
| 11 | `roam.md` | **planned** | import | ❌ tidak ada kode roam |
| 12 | `perplexity.md` | **planned** | import | ❌ tidak ada `PERPLEXITY_API_KEY` consumer di API |
| 13 | `openrouter.md` | **planned** | import (provider AI + browser-use) | ❌ slot ready di docs LLM provider, belum ada service openrouter |
| 14 | `9router.md` | **planned** | import (provider lokal AI Ceritas) | ❌ belum ada kode |
| 15 | `README.md` | katalog (bukan integrasi) | — | legend + tabel 14 baris, prinsip opt-in env + `ceritas_synced.json` + rate limit `middleware/security.js` |

Detail direction per file terverifikasi via `**Direction:**` header (output scan 7.1):
`9router=import(provider lokal)`, `openrouter=import(provider)`, sisanya sesuai tabel di atas.

---

## 2. Table Status AI-Guides (14 file = 12 guide + README + TEMPLATE)

Sumber: scan regex `planned|not implemented|TODO` (case-sensitive + case-insensitive) = **0 hit**. Semua file lengkap v1.0 mengikuti `_TEMPLATE.md`.

| # | File | Ukuran | Status | Peran (dari README) |
|---|---|---|---|---|
| 1 | `GEMINI.md` | 3457 B | ✅ lengkap | Multimodal, long context |
| 2 | `COPILOT.md` | 3341 B | ✅ lengkap | Code completion, inline suggestions |
| 3 | `OPENAI.md` | 3313 B | ✅ lengkap | General purpose, function calling |
| 4 | `DEEPSEEK.md` | 3290 B | ✅ lengkap | Reasoning berat, math/logic/code |
| 5 | `NOTEBOOKLM.md` | 3289 B | ✅ lengkap | Research synthesis, source-grounded Q&A |
| 6 | `CLAUDE.md` | 3250 B | ✅ lengkap | Writing berkualitas, code review |
| 7 | `MUSE.md` | 3228 B | ✅ lengkap | Creative writing, humanization H1-H5 |
| 8 | `OLLAMA.md` | 3215 B | ✅ lengkap | Local LLM, offline, privasi |
| 9 | `CONSENSUS.md` | 3195 B | ✅ lengkap | Academic paper search, evidence Q&A |
| 10 | `KIMI.md` | 3196 B | ✅ lengkap | Long context 200k+, document analysis |
| 11 | `OPENCODE.md` | 3164 B | ✅ lengkap | Agent utama, eksekutor command |
| 12 | `LEAPSPACE.md` | 3131 B | ✅ lengkap | AI workspace / knowledge assistant |
| 13 | `README.md` | 2323 B | indeks | Tabel 12 guide + aturan global (ID default, jangan sentuh fix-skill.md) |
| 14 | `_TEMPLATE.md` | 2281 B | template | Kerangka Konteks → Stack → Peran → Aturan → Command → Tools v11.8 → Cara Pakai → Batasan → Contoh |

Catatan:
- ke-12 guide menyebut Tools Integration v11.8 (`/research`, Sonner/Cmdk/DnD/OTP/virtuoso/chart, `docs/stack-options/`) — konsisten, bukan stub.
- `NOTEBOOKLM.md` (guide) eksplisit: "Tidak ada API resmi stabil — workflow via browser-use/manual copy, bukan otomatisasi production" + larangan upload `.env.production`. Ini selaras dengan `integrations/notebooklm.md` berstatus planned.
- Tidak ada file guide berstatus planned/TODO — gap = 0 di lapis panduan.

---

## 3. Table Service Default Project vs Batch

Sumber: `Get-ChildItem product/apps/api/services -Directory` = 12 dirs (11 + rps-batch). Cross-check `require('../<service>')` di seluruh `services/rps-batch/*.js`.

Service dirs (11 eks-rps-batch): `ai, audit, billing, exporters, humanizer, llm, parsers, plagiarism, scraping, secondbrain, templates`.

| Service dir | Dipakai batch? | Bukti require |
|---|---|---|
| `ai` | ✅ | `generator.js:427` → `require("../ai/paraphrase")` |
| `audit` | ✅ | `audit.js:8` → `require("../audit/tier")` |
| `humanizer` | ✅ | `generator.js:414,463`, `audit.js:9-10` → `humanizer/detect`, `humanizer/humanize`, `humanizer/index` |
| `llm` | ✅ | `generator.js:244,330,354,405`, `titleGenerator.js:56` → `require("../llm")` |
| `secondbrain` | ✅ (kondisional) | `references.js:102` → `require("../secondbrain/rag-client")` (di dalam try/catch runtime) |
| `billing` | ⚠️ belum dipakai batch | tidak ada `require('../billing')` — wajar (monetisasi, bukan RPS render path) |
| `exporters` | ⚠️ belum dipakai batch | tidak ada `require('../exporters')` — `rps-batch/exporter.js` standalone (`./queue`), bukan `services/exporters/` |
| `parsers` | ⚠️ belum dipakai batch | tidak ada `require('../parsers')` — `rps-batch/parser.js` internal, bukan `services/parsers/` |
| `plagiarism` | ⚠️ belum dipakai batch | tidak ada `require('../plagiarism')` — cek plagiasi terpisah (`routes/plagiarism.js`), belum masuk pipeline RPS |
| `scraping` | ⚠️ belum dipakai batch | tidak ada `require('../scraping')` — riset scraping (`/research`) belum ditarik ke `findReferences` |
| `templates` | ⚠️ belum dipakai batch | tidak ada `require('../templates')` — `rps-batch` pakai `rps-batch/templates/ieee-paper` internal, bukan `services/templates/` |

File-service yang dipakai batch tapi bukan direktori (pelengkap, bukan gap):
`bibtex` (`references.js:9`), `crossref` (`references.js:119`), `latex` (`latex.js:7`), `ppt` (`ppt.js:9`), `db/adapter` (`loadPresetFromDb.js`, `syncPresetToDb.js`).

**Service gaps: 6** (billing, exporters, parsers, plagiarism, scraping, templates).

---

## 4. Case Study: NotebookLM (contoh gap planned → code)

- **Doc:** `integrations/notebooklm.md` (Status planned, Direction import, Auth: Gemini API key jalur resmi atau browser-use jalur UI).
- **Kontrak API (dokumen saja):** `POST /integrations/notebooklm/ask` { question, sourceIds[] } → { answer, citations[] }; `POST /integrations/notebooklm/import` { answerId, paperId }.
- **Env:** `GEMINI_API_KEY`, `NOTEBOOKLM_ENABLED` (default false).
- **Kode:** tidak ada — grep `notebooklm` di `product/apps/api/**/*.js` = 0 hit; tidak ada `routes/integrations/notebooklm.js`, tidak ada `services/notebooklm/`, tidak ada mount di `server.js` (hanya `secondbrain` di `server.js:222-223`), tidak ada rate-limit khusus di `middleware/security.js` (hanya secondbrain import/ask).
- **Dependensi ganda planned:** jalur (b) butuh `browser-use.md` yang juga planned; jalur (a) butuh Gemini API langsung (bukan 1:1 NotebookLM, diakui di Implementation Notes).
- **Guide vs integration selaras:** `ai-guides/NOTEBOOKLM.md` menegaskan workflow manual/browser-use, larangan upload kredensial, jawaban hanya dari sources ter-upload — artinya NotebookLM hari ini adalah asisten eksternal manual, bukan integrasi API.
- **Pola umum:** 11 file planned mengikuti pola yang sama — panduan + kontrak API + env dirancang dulu, implementasi wavelet berikutnya. NotebookLM adalah representasi terbaik karena dependensinya (browser-use) juga planned sehingga prioritasnya harus diurutkan (browser-use atau Gemini-proxy dulu, baru NotebookLM ask/import).

---

## 5. Commands (7.4)

Path aktual: `.opencode/command/` (singular). 16 file:

`aicheck.md`, `deploy-prod.md`, `deploy.md`, `gaya.md`, `humanize.md`, `llm-finetune.md`, `makalah.md`, `menu.md`, `plagiasi.md`, `preset.md`, `research.md`, `rps-batch.md`, `secondbrain.md`, `seed-users.md`, `sso-billing.md`, `status.md`.

Catatan: spec 7.4 menulis `.opencode\command` — benar singular; glob `.opencode/command/*.md` di tool berpeforma rendah karena hidden dir, verifikasi via PowerShell `Get-ChildItem -Force ".opencode\command"` sukses (16 baris). Command `/research`, `/secondbrain`, `/rps-batch` memetakan 1:1 ke area gap (scraping, secondbrain partial, batch gaps).

---

## 6. Prioritas P0 / P1 / P2

### P0 (blokir value / inkonsistensi harus diputuskan dulu)
1. **Tegaskan definisi "active" untuk Zotero/Mendeley** — doc klaim active via `/sync/*`, verifikasi E2E prod (link → collections/documents → import → delete) + catat di smoke test. Jika lolos, pertahankan; jika gagal, turunkan ke partial.
2. **SecondBrain Railway story** — doc sendiri mengakui `D:\SecondBrain`/`localhost:8000` tak bisa diakses Railway Linux (graceful 503). Putuskan: volume mount / tunnel / disable resmi di prod + health tetap `{enabled:false}` by design. Tanpa ini partial selamanya merah di prod.
3. **RPS-batch `findReferences` tanpa scraping/plagiarism** — `references.js` pakai crossref + secondbrain-RAG kondisional, tapi `services/scraping/` dan `services/plagiarism/` tidak tersambung. Putuskan: sambungkan atau tandai eksplisit out-of-scope pipeline batch.

### P1 (value tinggi, effort sedang)
4. **Sambungkan `scraping` → batch** (`services/scraping/` → `rps-batch/references.js`) — menutup 1 dari 6 service gaps + memberi nyawa ke `/research` adapters di pipeline RPS.
5. **Sambungkan `plagiarism` audit → batch** (`audit.js` sudah panggil `auditTier` + humanizer; tambah plagiarism check ringan pasca-generate) — menutup 1 gap + selaras command `/plagiasi`.
6. **Rapikan `exporters` vs `rps-batch/exporter.js` vs `services/templates/`** — tiga jalur export (services/exporters, batch exporter internal, services/templates) tumpang tindih. Konsolidasikan atau dokumentasikan batasnya (siapa pemilik LaTeX/PPT/DOCX).
7. **Rapikan `parsers` vs `rps-batch/parser.js`** — sama: dua parser paralel. Pilih satu sebagai canonical atau jadikan batch parser sebagai wrapper tipis `services/parsers/`.
8. **Provider AI (OpenRouter/9Router)** — doc LLM provider sebut slot ready; kode belum ada service. Implementasi kecil (env + proxy + 429/quota) membuka fallback saat Gemini/Groq quota habis.

### P2 (nice-to-have, bidirectional PKM)
9. **Notion/Obsidian/Logseq/Roam/Hermes** — kelima bidirectional PKM planned. Mulai dari pola `ceritas_synced.json` yang sudah didok (mimic `notion_sync.py`) untuk satu target dulu (Notion), baru generalisasi.
10. **YouTube transcript + Perplexity** — import-only, independen. Cocok sebagai batch kecil terpisah (transcript → reference; Perplexity → research citation).
11. **NotebookLM ask/import** — setelah P1.8 (provider) + browser-use diputuskan. Jangan mulai sebelum dependensi jalur (a)/(b) jelas; jika tidak, pertahankan sebagai workflow manual via `ai-guides/NOTEBOOKLM.md`.
12. **Billing → batch** — sengaja terpisah; cukup tambah guard kuota/entitlement di `orchestrator.js` (bukan full billing di pipeline).

---

## 7. Lampiran — perintah audit yang dijalankan

```powershell
# 7.1
Get-ChildItem "integrations" -Filter "*.md" | ForEach-Object {
  $content = Get-Content $_.FullName -Raw
  $status = if ($content -match '\*\*Status:\*\*\s*(\w+)') { $matches[1] } else { 'unknown' }
  "$($_.Name) → $status"
}
# 7.2
Get-ChildItem "ai-guides" -Filter "*.md" | ForEach-Object {
  $content = Get-Content $_.FullName -Raw
  if ($content -match 'planned|not implemented|TODO') {
    "⚠️ $($_.Name) — planned/TODO"
  }
}
# 7.3
$services = Get-ChildItem "product\apps\api\services" -Directory | Select-Object -ExpandProperty Name
$batchCode = (Get-Content "product\apps\api\services\rps-batch\*.js" -Raw) -join "`n"
foreach ($s in $services) {
  if ($s -eq "rps-batch") { continue }
  $used = $batchCode -match "require\('\.\./$s"
  if ($used) { "✅ $s" } else { "⚠️ $s — belum dipakai batch" }
}
# 7.4
Get-ChildItem ".opencode\command" -Filter "*.md" | Select-Object Name
```

Hasil aktual sedikit berbeda dari ekspektasi spec (dicatat jujur di atas):
- 7.2 = 0 hit (guides lengkap, bukan stub) — bukan 12 warning.
- 7.3 `Get-Content ...\*.js -Raw` mengembalikan array (bukan single string) di PS 5.1 — audit ini memakai `Select-String -Pattern "require\(..\/"` per-file + join rekursif sebagai pengganti yang setara.
- 7.4 path singular `.opencode\command` terkonfirmasi benar (16 file); varian plural `.opencode\commands` tidak ada.

---

## 8. Integration Roadmap (OPSI D — 2026-09-20)

> Semua 11 file `planned` kini lengkap mengikuti template standar
> (Overview → Use Case → Setup → API → Implementasi/Future → Batasan → Referensi,
> header Status + Prioritas + Direction + Auth). Guide selesai; tinggal kode
> bila ada demand. Detail per file: `integrations/README.md` + `docs/AUDIT-INTEGRATION.md`.

### P0 — putuskan dulu (bukan kode baru)

| # | Item | Kriteria selesai |
|---|---|---|
| P0.1 | Verifikasi E2E Zotero/Mendeley prod (link → collections/documents → import → delete) | Lolos smoke test → pertahankan `active`; gagal → turunkan ke `partial` |
| P0.2 | SecondBrain Railway story (volume/tunnel/disable resmi di prod) | Health `{enabled:false}` by design terdokumentasi, `partial` tidak merah selamanya |

### P1 — value tinggi, effort sedang (kerjakan pertama bila ada demand)

| # | Integration | Kenapa P1 | File kode future |
|---|---|---|---|
| P1.1 | OpenRouter | Failover saat kuota Gemini/Groq habis; slot ready sejak v11.6, effort = provider baru di registry | `services/llm/providers/openrouter.js` + enum `LLM_PROVIDER` |
| P1.2 | 9Router | Mode offline kampus + privasi skripsi; pola sama dengan OpenRouter | `services/llm/providers/9router.js` + enum `LLM_PROVIDER` |
| P1.3 | Perplexity | Sitasi web real-time untuk gap analysis 2025-2026; independen; supplement CrossRef di `references.js` (P1.4) | `services/perplexity/client.js`, `routes/integrations/perplexity.js` |

Urutan: P1.1 → P1.2 (satu pola provider) → P1.3 (research citation).

### P2 — nice-to-have (antre setelah P1)

| # | Integration | Ketergantungan | File kode future |
|---|---|---|---|
| P2.1 | Notion | — (mulai PKM dari sini, pola `ceritas_synced.json`) | `services/notion/{client,mapper}.js`, `routes/integrations/notion.js` |
| P2.2 | Obsidian | — (reuse parser SecondBrain) | `services/obsidian/{reader,writer}.js`, `routes/integrations/obsidian.js` |
| P2.3 | Logseq | — | `services/logseq/reader.js`, `routes/integrations/logseq.js` |
| P2.4 | Roam | — (JSON dulu, EDN tahap 2) | `services/roam/parser.js`, `routes/integrations/roam.js` |
| P2.5 | Hermes | Discovery path + format memori aktual | `services/hermes/{memory,context}.js`, `routes/integrations/hermes.js` |
| P2.6 | YouTube | — (yt-dlp + Whisper, job async) | `services/youtube/{fetcher,queue}.js`, `routes/integrations/youtube.js` |
| P2.7 | Browser-use | Butuh P1.1 (LLM driver) + venv Python | `services/browser-use/{worker.py,index.js}`, `routes/integrations/browser-use.js` |
| P2.8 | NotebookLM | TERAKHIR — butuh P2.7 (jalur b) atau Gemini-proxy (jalur a) diputuskan dulu | `services/notebooklm/{gemini,browser}.js`, `routes/integrations/notebooklm.js` |

Aturan urutan: P2.8 jangan mulai sebelum P2.7/P1.1 jelas (dependensi ganda planned —
lihat §4 case study). P2.1–P2.6 independen, bisa paralel per file.

### Status akhir OPSI D

- 11/11 guide planned lengkap (template standar + adapter sketch + file list future).
- `integrations/README.md`: tabel 14 baris + kolom Prioritas + ringkasan (2 active, 1 partial, 11 planned; 3× P1, 8× P2) + link audit.
- Implementasi kode: 0 (by design — menunggu demand + P0 diputuskan).

---

## Update 2026-09-21 (Integration Audit — ref `docs/INTEGRATION-AUDIT-2026-09-21.md`)

### 🚨 P0.1 — Renderer `uin` tidak ada di rps-batch (BLOCKER regen matkul-02/03)
- Bukti: `services/rps-batch/latex.js:3,54` — `template: uin` fallback diam-diam ke render IEEE
  (hanya catat note di meta); `services/rps-batch/templates/` hanya berisi `ieee-paper.js`.
- Dampak: regen matkul-02/03 (config `template: uin`) akan menghasilkan IEEE, bukan makalah 7-bagian.
- Opsi fix: (a) implement `services/rps-batch/templates/uin-paper.js`;
  (b) route `uin` via `services/templates` engine `log-makalah` (sudah dipakai `routes/papers.js:169`).
- Status: OPEN — wajib selesai sebelum `/rps-batch generate --matkul 02/03`.

Service USED/UNUSED terbaru (require-level): 8 USED / 2 UNUSED (`billing`, `scraping` — by design)
/ 1 WIRED-OFF (`secondbrain`, `use_secondbrain: false`) / 1 SPLIT (`templates` — lihat P0.1).
