# Makalah Ceritas — Dokumentasi Publik

Skill OpenCode untuk tiga format naskah akademik:

| Format | Template | Output |
|---|---|---|
| Artikel IEEE 2 kolom | `assets/template-ieee/` | PDF via `pdflatex → bibtex → pdflatex ×2` |
| Makalah UIN 1 kolom | `assets/template-makalah/` | PDF jilid + softfile |
| Artikel Elsevier preprint 1 kolom | `assets/template-elsevier/` | PDF preprint |

## Isi dokumentasi

| Dokumen | Isi |
|---|---|
| [`parafrase-tiers.md`](parafrase-tiers.md) | 7 tier gaya akademik (T1–T7) + prompt master 3 tahap + verifikasi §5 |
| [`verifikasi.md`](verifikasi.md) | Cara menjalankan `verify-tier.ps1` + arti PASS / WARN / FAIL |
| [`prompt-master.md`](prompt-master.md) | Kapan memakai NotebookLM vs OpenCode vs Claude + contoh prompt |
| [`README.md`](README.md) | Navigasi + konvensi penulisan docs |
| [`TASK_BREAKDOWN.md`](../TASK_BREAKDOWN.md) | 21 task turunan dari 7 tier (repo root) |
| [`C9_MIGRATION_LOG.md`](../C9_MIGRATION_LOG.md) | Log migrasi footnote BAB I (repo root) |

Aturan global proyek: **jangan mengarang** — data yang tak ada tertulis `TIDAK_TERSEDIA`;
konflik dicatat dua versi dan tidak diputuskan sepihak.

## Quick start untuk kontributor baru

```powershell
# 1. Clone sebagai skill (struktur hasil clone siap dipakai)
git clone https://github.com/whoolm/makalah-ceritas-public.git "$env:USERPROFILE\.opencode\skills\makalah-ceritas"

# 2. Dari root repo, audit satu draft tier T1
.\scripts\verify-tier.ps1 -FilePath "makalah-hadis/draft/BAB_I_PENDAHULUAN_PARAFRASE.md" -Tier "T1"

# 3. Lihat backlog kerja
#    TASK_BREAKDOWN.md — mulai dari label good-first-issue (TASK-T1-01 … TASK-T2-02)
```

Alur kerja ringkas: **Tahap 1 NotebookLM** (ekstraksi konten) →
**Tahap 2 OpenCode** (draft T1) → **Tahap 3 Claude** (upgrade tier) →
**verifikasi otomatis** (`verify-tier.ps1`, juga jalan di CI setiap push/PR ke `main`).
Detail tiap tahap: [`prompt-master.md`](prompt-master.md).
