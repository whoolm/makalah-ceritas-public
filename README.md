# Makalah Ceritas — Skill Installer (OpenCode)

Repo ini = installer skill `makalah-ceritas` (artikel IEEE 2-kolom, makalah UIN 1-kolom, artikel Elsevier preprint 1-kolom).

## Install sebagai skill

```powershell
git clone https://github.com/whoolm/makalah-ceritas-public.git "$env:USERPROFILE\.opencode\skills\makalah-ceritas"
```

Struktur hasil clone = struktur skill (`SKILL.md`, `assets/`, `references/`, `scripts/`) — siap dipakai tanpa langkah tambahan.

## Isi repo

| Path | Isi |
|---|---|
| `SKILL.md` | SOP skill (routing 3 format) |
| `assets/template-ieee/` | Template artikel IEEE 2 kolom |
| `assets/template-makalah/` | Template makalah UIN 1 kolom |
| `assets/template-elsevier/` | Template artikel Elsevier preprint 1 kolom |
| `references/` | Aturan format + prompt library + troubleshooting |
| `scripts/` | Build script makalah UIN (`build-*.ps1`) |
| `PROMPT_CATALOG.md` | Katalog prompt AI proyek |

---

# Makalah Ceritas — Repo PRD & Riset (Baseline v1.0-prd)

Sumber: 6 percakapan DeepSeek (376 pesan) yang diekstrak apa adanya. Aturan repo: **jangan mengarang** — yang tak ada datanya tertulis `TIDAK_TERSEDIA`; konflik dicatat dua versi dan TIDAK diputuskan sepihak.

## Navigasi cepat

| Saya ingin... | Buka |
|---------------|------|
| Gambaran semua file | `MANIFEST.md` |
| Memahami produk + kebutuhan | `PRD.md` (§1–§4 ringkas; §5 FR; §6 NFR; §15–§19 hardening) |
| Memahami metodologi riset | `METODOLOGI_RESEARCH.md` |
| Lacak requirement → chat sumber | `TRACEABILITY.md` / `TRACEABILITY.csv` (69 TR, kolom `chat_id`+`message_index`) |
| Lihat hasil audit ekstraksi | `AUDIT_REPORT.md` |
| Lihat yang butuh keputusan saya | `PENDING_DECISIONS.md` (PD-01–PD-13, K-01–K-13) |
| Riwayat perubahan | `CHANGELOG.md` |
| Timeline pengerjaan | `ROADMAP.md` |
| Cara kontribusi | `CONTRIBUTING.md` |
| Data | `raw/` (mentah) → `extracted/` (transkrip) → `memory/` (konsolidasi) |

## Status baseline

- ✅ 6/6 chat terekstrak (fetch via API internal; HTML terhalang WAF — lihat `raw/errors.log`)
- ✅ PRD + metodologi + traceability v2 (69 TR: 54 confirmed, 13 inferred, 2 conflicting)
- ⏳ 9 konflik terbuka (K-01–K-09) + 13 pending decision (PD-01–PD-13) menunggu manusia
- 🔲 NFR tanpa angka (`[PERLU TARGET ANGKA]`) — menunggu manusia
