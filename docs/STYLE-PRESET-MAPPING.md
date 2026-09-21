# Style Preset ↔ Config.md Mapping (FASE 3)

Sumber audit:
- DB: `product/apps/api/db/migrations/012_style_presets.sql` (sqlite)
  + counterpart PG `product/apps/api/db/migrations-pg/007_style_presets.sql`
- API: `product/apps/api/routes/style-presets.js` via `services/stylePresets.js`
- Config: `product/apps/api/services/rps-batch/config.js` (loader) + `D:/Ceritas-Batch/config.md` (runtime)

Catatan penting: nama kolom DB adalah **camelCase** (`orgId`, `citationStyle`,
`lengthTarget`, `plagiarismCheck`, `isDefault`, …) — bukan snake_case.
Query portable WAJIB pakai gaya adapter (`?` / `@nama`, camelCase) — lihat
`db/adapter.js`. Contoh `$1` / `org_id` / `gen_random_uuid()` / `NOW()`
TIDAK portable ( Liver sqlite + PG-quote).

## Tabel mapping

| Config.md field | DB column | Tipe | Mapping |
|---|---|---|---|
| `formality` | `formality` | enum | 1:1 (`formal`/`semi-formal`/`santai` sama di kedua sisi) |
| `length_target` | `lengthTarget` | enum | 1:1 (`pendek`/`sedang`/`panjang` sama) |
| `citation_style` | `citationStyle` | enum | **parsial** — iris bersama: `APA`/`IEEE`/`MLA`/`Chicago`; DB-plus: `Harvard`, `Vancouver` (di-skip saat load); selalu valid saat sync (config ⊆ DB) |
| `bahasa` | `bahasa` | enum | **konversi** — DB `id-formal`/`id-semi`/`en-academic`/`mix` ↔ config `id`/`en` (`id-formal`,`id-semi`,`mix`→`id`; `en-academic`→`en`; baliknya `id`→`id-formal`, `en`→`en-academic`) |
| `plagiarism_check` | `plagiarismCheck` | enum | **konversi ejaan** — DB `external` ↔ config `eksternal`; `internal`/`off` 1:1 |
| `template` | `template` | enum | **TIDAK dipetakan** — enum tidak beririsan (DB: `log-makalah`/`full-paper`/`essay`/`review`; config: `ieee`/`uin`/`elsevier`); di-skip dua arah + warning |
| (label preset) | `name` | text | dipakai sebagai kunci upsert sync (`orgId` + `name`), bukan field config |
| (lookup default) | `isDefault` | bool | dipakai mode `db` bila `style_preset_id` kosong (ambil default scope org/user) |
| (scoping) | `orgId`, `userId` | fk | scope baca/tulis, bukan field config |
| (meta) | `id`, `createdAt`, `updatedAt` | meta | meta saja |
| (baru, bukan DB) | `preset_source` | `file`/`db`/`hybrid` | mode bridge, hanya di config |
| (baru, bukan DB) | `style_preset_id` | string\|null | id preset untuk mode `db`, hanya di config |

## Gap — ada di DB, tidak ada di config (di-skip saat load ke config)

- `template` (enum tidak beririsan — lihat di atas)
- `name`, `isDefault`, `orgId`, `userId`, `id`, `createdAt`, `updatedAt` (label/scope/meta)

## Gap — ada di config, tidak ada di DB (TIDAK di-sync ke DB)

- `humanize_level`, `paraphrase_tier` (Fase 4 — STOP, jangan ditambah ke DB di fase ini)
- `min_references`, `sections`, `batch_root`, `max_retries`
- `use_secondbrain`, `use_crossref`
- `mode`, `title_mode`, `title_style`, `title_custom`
- `authors`, `author_style`, `dosen`, `kelas`
- `preset_source`, `style_preset_id` (meta bridge)

## Arah sync (Fase 3 = one-way, file → DB)

- `syncPresetToDb.js`: config.md → upsert `style_presets` by (`orgId`, `name`).
  Hanya kolom terpetakan yang ditulis; `template` TIDAK ditulis (enum tak cocok).
- `loadPresetFromDb.js` + `preset_source=db|hybrid`: DB → override config
  (dipakai Fase 3 untuk baca; tulis balik tetap via sync script).
