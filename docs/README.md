# Docs — Navigasi & Konvensi

## Navigasi

| File | Untuk siapa |
|---|---|
| [`index.md`](index.md) | Semua orang — mulai dari sini |
| [`parafrase-tiers.md`](parafrase-tiers.md) | Drafter / reviewer — referensi 7 tier + prompt + verifikasi |
| [`verifikasi.md`](verifikasi.md) | Verifier — menjalankan `verify-tier.ps1`, membaca PASS/WARN |
| [`prompt-master.md`](prompt-master.md) | Drafter — memilih tahap NotebookLM / OpenCode / Claude |

Dokumen terkait di root repo: `TASK_BREAKDOWN.md` (backlog 21 task),
`C9_MIGRATION_LOG.md` (log migrasi BAB I), `.github/workflows/README.md` (CI).

## Konvensi penulisan docs

1. Bahasa: Indonesia (kutipan prompt EN dipertahankan aslinya).
2. Istilah asing/arab: *italic* (`*sanad*`, `*first-principles*`).
3. Sitasi gaya narasi: `(Nama, Tahun)` — sama seperti naskah T1.
4. Jangan mengarang: data tak ada = `TIDAK_TERSEDIA`; konflik = catat dua versi.
5. `docs/parafrase-tiers.md` adalah **salinan publik** dari
   `references/parafrase-tiers.md` + badge build + bagian "Cara Berkontribusi".
   Bila referensi berubah, sinkronkan salinannya dan sebutkan di commit.
6. Contoh output perintah ditempel apa adanya dalam blok ```text```.
