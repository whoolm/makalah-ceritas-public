# Verifikasi Parafrase (§5.1–§5.5)

Skrip: `scripts/verify-tier.ps1` (sumber aturan: `references/parafrase-tiers.md` §5).

## §5.1 — Panjang kalimat rata-rata

Total kata ÷ total kalimat (kalimat = potongan teks yang dipisah `.`/`!`/`?`).
Target per tier: T1 15–25 · T2 20–30 · T3 25–35 · T4 25–35 · T5 20–30 · T6 15–25 · T7 10–20.

## §5.2 — Sitasi preserved

Setiap klaim memakai sitasi `(Nama, Tahun)`; komparasi tier asal vs target harus
menunjukkan **delta 0%** (boleh tambah referensi konteks, tidak boleh hapus).
Diketahui: regex script `([A-Z][a-zA-Z\s\.]+?,?\s+\d{4})` hanya menangkap sitasi
penulis-tunggal sederhana — sitasi `&` / `et al.` / grup `;` tidak terhitung
(lihat `C9_MIGRATION_LOG.md` §4). Jangan hapus sitasi demi "mengejar" angka script.

## §5.3 — Istilah Arab preserved

Istilah seperti *sanad*, *matan*, *maudu'* ditulis italic (`*...*`) dan harus
**0 hilang** setelah upgrade tier.

## §5.4 — Hedging density

Tiap tier punya kosakata hedging khas (T1 "dapat dikatakan/menurut" … T5
"reveals/demonstrates/revises" … T7 "we reformulate/we challenge"). Target
acuan T5: 0.5–1.5%.

## §5.5 — Audit lengkap (`verify-tier.ps1`)

```powershell
.\scripts\verify-tier.ps1 -FilePath "<file>" -Tier "T1"
# Tier valid: T1 T2 T3 T4 T5 T6 T7
```

## Interpretasi hasil

| Status | Arti | Tindakan |
|---|---|---|
| `PASS` | Panjang kalimat + sitasi/kalimat dalam target tier | Lanjut |
| `WARN` | Di luar target — **tetap lolos** | Baca angkanya; pecah/gabung kalimat atau cek sitasi bila perlu |
| (`FAIL`) | Versi script saat ini tidak mengeluarkan FAIL; workflow CI gagal bila status tak dikenali | Perbaiki input / script |

## Contoh output

```text
=== AUDIT TIER T1 ===
File: makalah-hadis/draft/BAB_I_PENDAHULUAN_PARAFRASE.md

Total kata: 1636
Total kalimat: 71
Rata-rata panjang kalimat: 23 kata (target: 15-25)
Total sitasi: 2
Sitasi per kalimat: 0.03 (target: 0.3-0.5)

WARN: Sitasi density di luar target

Status: WARN
```

Contoh di atas = **WARN yang lolos**: panjang kalimat PASS (23 masuk 15–25);
peringatan sitasi adalah keterbatasan regex (isi aktual: 48 grup / 110 entri,
≈1.55 per kalimat — di atas minimum T1). CI memperlakukan WARN sebagai sukses.
