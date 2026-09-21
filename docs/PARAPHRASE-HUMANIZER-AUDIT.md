# Paraphrase + Humanizer Audit (FASE 4 — LANGKAH 1)

Tanggal: 2026-09-20. Read-only audit sebelum integrasi proper.

## Paraphrase Service

- File: `product/apps/api/services/ai/paraphrase.js` (94 baris)
- Signature aktual: `paraphrase({ text, tier })` — **object arg**, BUKAN `paraphrase(text, {...})`
- Return aktual: `{ paraphrased, tier, confidence, reason, aiUsed, cached, usage, ms }`
  — BUKAN `{ text, ... }`. Gagal = `{ paraphrased: null, reason }`
- Tier support: `T1, T2, T3, T4, T5, T6, T7, T1-Lit` (VALID_TIERS Set)
- Source tier rules: `services/llm/prompts.js` → `buildParaphrasePrompt({ text, tier })`
  (aturan tier dari PARAFRASE_TIERS.md, di-render jadi system+user prompt)
- Fallback: jujur — LLM disabled / parse gagal / output >2x input → `paraphrased: null + reason`,
  teks asli tetap dipakai pemanggil. Batas input 8000 char, maxTokens 1200, temp 0.7
- Catatan: butuh LLM (`services/llm` complete). Tanpa LLM → selalu fallback teks asli

## Humanizer Service

- File: `product/apps/api/services/humanizer/humanize.js` (123 baris) + `index.js` facade + `detect.js` + `style.js` + `external.js`
- Signature aktual: `humanize(text, level, preset)` — **positional**, BUKAN `humanize(text, { level, ... })`
- Return aktual: `{ text, provider, changes, changePct?, styleApplied?, skipped?, note? }`
  — TIDAK ada `preScore/postScore` (skor via `detect()` terpisah di `index.js` facade)
- Level: H1-H5
  - H1 = deteksi saja, tanpa rewrite (`{ text: src, provider: "none" }`)
  - H2 = coba LLM dulu, fallback lokal synonym-swap (provider `fallback-synonym`)
  - H3 = coba LLM dulu, fallback lokal synonym + pecah kalimat (provider `fallback-split`)
  - H4/H5 = coba LLM, **tanpa LLM = skipped jujur** (`skipped: true`, teks tidak diubah)
- Local mode: kamus sinonim ID/EN (~30 pasang, whole-word, cap ~12 changes) + split kalimat >22 kata
- LLM mode: `buildHumanizePrompt({ text, level, preset })` + `applyAuthorStyle` (preset gaya penulis),
  maxTokens 2000, temp 0.8
- Output shape: `{ text, provider, changes, skipped?, note? }`
- Detect: `detect(text)` → `{ score (0-100), heuristic, external, recommendedLevel }`;
  `detectHeuristic` sinkron, lokal, murah (5 dimensi: burstiness, lexical diversity,
  connector density, sentence-start variety, repetitive n-gram)
- LLM availability: `services/llm` → `effectiveProvider()` returns `"none"` bila tak ada provider ready

## Generator.js Integration (saat ini)

- File: `product/apps/api/services/rps-batch/generator.js` (`generatePaper`, 431 baris)
- Current: **hint saja / tidak apply sama sekali**
  - `grep paraphrase|humanize` di generator.js → NOL hook (hanya "max_tokens"/"TPM burst")
  - `styleHint()` hanya kirim keywords/banned_words sebagai hint prompt LLM
  - `config.paraphrase_tier` hanya di-echo ke meta via orchestrator (`paraphraseTier: config.paraphrase_tier`)
    tanpa pernah dipanggil
- Humanize aktual terjadi di `services/rps-batch/audit.js` → `auditTopic()`:
  `detect pre → humanize(whole markdown, level) → detect post → report`.
  Catatan: `humanize(src, level)` dipanggil TANPA preset author_style (preset hilang),
  dan whole-doc rewrite berisiko menyentuh blok referensi/DOI/URL + `\cite{key}` bila via LLM
- `auditTier(src, "T1-Lit")` di audit.js hardcode tier — mengabaikan `config.paraphrase_tier`
- Hook point Fase 4: di `generatePaper()` setelah `completeSection()` per section
  (paraphrase), lalu post-loop per section (humanize), SEBELUM abstract/keywords narrative
  di-generate (agar abstrak diringkas dari teks final)

## Gap

- Paraphrase: hint/echo saja → apply proper per-section via `paraphrase({ text, tier })`,
  dengan adaptor field (`paraphrased` → `text`) karena signature aktual beda dari draf umum
- Humanizer: whole-doc tanpa preset di audit.js → per-section H1-H5 full di generator
  dengan preset `config.author_style`, skor pre/post per section via `detectHeuristic`,
  dan `skipHumanize` di audit agar tidak double-rewrite
- Config ENUMS: `paraphrase_tier: [T1|T2|T3]` sempit (service dukung T1-T7 + T1-Lit) + tanpa `none`;
  `humanize_level` tanpa `none`. Perlu pelebaran (widening, aman untuk validate)
- Safety: rewrite LLM (paraphrase/H4-H5) bisa merusak `\cite{key}` sitasi LaTeX (PIH v3.1 WAJIB
  `\cite`) → guard: bila key sitasi hilang setelah rewrite, fallback teks asli
- Skip list: `judul` (diganti title generator), `referensi`/`daftar_pustaka` (renderRefs —
  jangan di-rewrite agar DOI/URL/APA utuh), placeholder `[butuh AI...]` (LLM gagal)
