# Prompt Master — 3 Tahap (NotebookLM → OpenCode → Claude)

Sumber: `references/parafrase-tiers.md` §4. Prinsip: tiap tier = transformasi
STYLE, bukan CONTENT (sitasi, istilah Arab, heading, fakta tetap 100%).

## Kapan pakai tahap mana

| Tahap | Alat | Kapan | Sifat |
|---|---|---|---|
| 1. Ekstraksi konten | NotebookLM | Punya kumpulan sumber, belum ada outline / belum tahu gap riset | Tier-agnostic (fokus konten) |
| 2. Draft T1 | OpenCode | Outline + referensi siap, butuh draft Bab I–III | Selalu tier T1 (mahasiswa S1) |
| 3. Upgrade tier | Claude | Draft T1 ada, target jurnal/tesis/disertasi diketahui | T1 → T2…T7 sesuai target |

## Tahap 1 — NotebookLM (ekstraksi, tier-agnostic)

Upload seluruh sumber, lalu:

```text
Peran Anda: reviewer akademik senior.

Tugas: analisis GAP RISET dari seluruh makalah yang saya upload.

Langkah:
1. Identifikasi TOPIK UTAMA yang dibahas.
2. Klasifikasikan: jenuh / diperdebatkan / belum tergarap.
3. Untuk topik belum tergarap: kenapa gap, metode rekomendasi, sitasi terdekat.
4. Ranking berdasarkan urgensi, eksekusi, kontribusi.

Output: tabel + narasi ringkas.
```

## Tahap 2 — OpenCode (draft T1)

```text
Baca:
- PUSTAKA_INTI.md (35 referensi)
- DRAFT_SKELETON.md (framework)

Generate Bab I-III di tier T1 (mahasiswa S1):
- Register formal-akademik dasar
- Kalimat 15-25 kata
- Hedging: "menurut X", "hal ini menunjukkan"
- Sitasi (Nama, Tahun) di setiap klaim
- Istilah Arab italic

Preserve: struktur heading, 100% sitasi.
Output: draft per bab (5 file terpisah).
```

## Tahap 3 — Claude (upgrade tier)

```text
Draft ini di tier T1 (mahasiswa S1). Upgrade ke tier {TARGET}.

Aturan tier {TARGET}:
{Baca karakteristik dari PARAFRASE_TIERS.md section 3}

Preserve 100%:
- Sitasi (Nama, Tahun) — posisi, ejaan, urutan
- Istilah Arab italic (*sanad*, *matan*, *maudu'*, dll.)
- Struktur heading (# BAB I, ## A. ...)
- Substansi fakta, argumen, kesimpulan

Ubah hanya STYLE:
- Register (formalitas)
- Panjang & struktur kalimat
- Hedging vocabulary
- Kepadatan leksikal
- Sitasi density (boleh tambah referensi context, tapi tidak boleh hapus)

Toleransi panjang: ±15% dari asli.

Output: file per bab + laporan tier transformasi.
```

Ganti `{TARGET}` dengan T2–T7 sesuai tujuan (panduan 10 detik: UAS→T1,
tesis→T2, disertasi→T3, SINTA/Scopus Q3-Q4→T4, Scopus Q1-Q2→T5,
Nature/Science→T6, position paper→T7). T7 adalah genre berbeda (bukan
"lebih tinggi dari T6") — reframe langsung dari T1.
