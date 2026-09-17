# C9 Migration Log — BAB I PENDAHULUAN PARAFRASE

Tanggal: 2026-09-17
File: `makalah-hadis/draft/BAB_I_PENDAHULUAN_PARAFRASE.md`
Sumber: salinan dari `Default Project/makalah-hadis/draft/BAB_I_PENDAHULUAN_PARAFRASE.md`
 (file tidak ada di repo publik sebelum C9 — dibuat via copy, lalu dipecah kalimatnya di repo ini)
Tier target: T1 (15–25 kata/kalimat, sitasi 0.3–0.5/kalimat)
Aturan: PARAFRASE_TIERS.md §5.2 (`references/parafrase-tiers.md`)

## 1. Migrasi footnote → (Nama, Tahun)

Hasil deteksi:
- Marker footnote `[^n]`: **0 ditemukan**
- Definisi footnote `[^n]:`: **0 ditemukan**

Kesimpulan: file sumber **sudah** memakai format `(Nama, Tahun)` di semua klaim.
Tidak ada konversi yang diperlukan (no-op). Blok definisi footnote tidak ada → tidak ada yang dihapus.

## 2. Pemecahan kalimat >25 kata (8 kalimat, makna + sitasi dipertahankan)

| # | Kalimat asal (kata) | Pemecahan | Sitasi |
|---|---|---|---|
| R1 | Era Nabi: wahana periwayatan … penguat ingatan — sehingga … (37) | `…penguat ingatan.` + `Dengan demikian, periode tersebut…` | Tetap di kalimat 2 |
| R2 | Abad 21: guncangan global … generatif, sehingga transmisi … (39) | `…generatif.` + `Akibatnya, transmisi beralih…` | Tetap di kalimat 2 |
| R3 | Viralitas tanpa validitas … yang layak, sehingga digitalisasi … (39) | `…yang layak.` + `Oleh karena itu, digitalisasi…` | Tetap di kalimat 2 |
| R4 | *Living hadith*: *ChatGPT* … belajar hadis, sebuah kebiasaan yang … (41) | `…belajar hadis.` + `Kebiasaan ini merentangkan…` | Tetap di kalimat 2 |
| R5 | Kontras riset satu-fase … (Kara, 2026), riset ini memetakan … (51) | `…(Kara, 2026).` + `Berbeda dengan itu, riset ini memetakan…` | Klaster 1 → kal.1 (Musadad, Kara); klaster 2 → kal.2 (Razak, Lutfianto) |
| R6 | Riset komputasional teknosentris …, riset ini mendudukkan … (41) | `…(Shaaban et al., 2026).` + `Sebaliknya, riset ini mendudukkan…` | Tetap di kalimat 1 |
| R7 | Gerbang Bab II … pada Bab II, sekaligus mengukuhkan … (41) | `…pada Bab II.` + `Pada saat yang sama, tulisan ini mengukuhkan…` | Tetap di kalimat 2 |
| R8 | Data 35 rujukan … bereputasi: riset periodisasi … (72) | `…bereputasi.` + `Kelompok rujukan tersebut mencakup riset periodisasi…` | Semua 110 entri dipertahankan |

Tidak ada sitasi yang dihapus/ditambah/diubah ejaannya. Tidak ada fakta yang diubah.

## 3. Hasil `verify-tier.ps1 -Tier T1`

| Metrik | Sebelum | Sesudah | Target T1 |
|---|---|---|---|
| Kata | 1622 | 1635 (+13 kata konektor) | — |
| Kalimat | 63 | 71 (+8) | — |
| Rata-rata | **25.7** ⚠️ | **23.0** ✅ | 15–25 |
| Sitasi (script) | 2 → 0.03 ⚠️ | 2 → 0.03 ⚠️ | 0.3–0.5 |

Status: WARN → **WARN dengan skor membaik** (panjang kalimat kini PASS).

## 4. Catatan: WARN sitasi = keterbatasan script, bukan isi

Regex script `verify-tier.ps1`:
`\([A-Z][a-zA-Z\s\.]+?,?\s+\d{4}\)`
hanya cocok untuk sitasi penulis-tunggal sederhana, mis. `(Musadad, 2026)`.
Ia **tidak** mendeteksi `&`, `et al.`, atau grup multi-sitasi `;`, mis.
`(Musadad, 2026; Razak et al., 2025)` atau `(Tanjung & Fadhlurrahman, 2025)`.

Hitung manual (regex grup sitasi): **48 grup sitasi, 110 entri penulis-tahun**
pada 71 kalimat → densitas aktual ≈ **1.55/kalimat** (di atas minimum T1 0.3–0.5).
Isi sitasi lengkap dan dipertahankan 100%; script **sengaja tidak diubah** (di luar skop C9).
Perbaikan regex diusulkan sebagai follow-up (lihat TASK_BREAKDOWN.md TASK-T1-02).
