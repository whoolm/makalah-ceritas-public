# Workflow `verify-tier`

Audit parafrase otomatis memakai `scripts/verify-tier.ps1` (PARAFRASE_TIERS §5.5).

## Kapan workflow jalan

- `push` ke branch `main`
- `pull_request` ke branch `main`

File workflow: `.github/workflows/verify-tier.yml` (runner `windows-latest`).

## Cara baca hasil

1. Buka tab **Actions** di GitHub → pilih run `verify-tier`.
2. Lihat step **"Verify semua draft `*_PARAFRASE.md`"**:
   - Per file tercetak hasil `verify-tier.ps1` + baris `Status: PASS/WARN/FAIL`.
   - Ringkasan akhir: `files=N pass=P warn=W fail=F`.
3. **FAIL** (atau status tak dikenali) → workflow **gagal** (merah). **WARN** → tetap **lolos** (hijau), tetapi peringatannya wajib dibaca.
4. Unduh artifact **`verify-tier-results`** untuk `verify-results.json`, `verify-summary.txt`, dan `C9_MIGRATION_LOG.md`.

Konvensi tier per file (otomatis, dapat dioverride dengan mengganti nama):
- `...TIER-Tn...` / `..._Tn.md` / folder `.../Tn/...` → tier `Tn`
- selain itu → default **T1**

## Cara debug lokal (jalankan script manual)

```powershell
# Dari root repo:
.\scripts\verify-tier.ps1 -FilePath "makalah-hadis/draft/BAB_I_PENDAHULUAN_PARAFRASE.md" -Tier "T1"
```

Interpretasi (lihat `docs/verifikasi.md`):
- `PASS` = panjang kalimat + sitasi/kalimat dalam target tier.
- `WARN` = di luar target, tetap lolos — periksa angkanya, perbaiki bila perlu.
- Diketahui: regex sitasi script hanya mendeteksi sitasi penulis-tunggal sederhana
  (mis. `(Musadad, 2026)`), sehingga sitasi `&` / `et al.` / grup `;` tidak terhitung
  dan densitas tampil kecil. Lihat `C9_MIGRATION_LOG.md` §4. Jangan hapus sitasi
  untuk "mengejar" angka script.
