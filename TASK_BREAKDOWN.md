# Task Breakdown — Parafrase Tiers v1.0

Sumber: `references/parafrase-tiers.md` (7 tier, T1–T7) + `scripts/verify-tier.ps1`.
Setiap tier = transformasi STYLE, bukan CONTENT (fakta, sitasi, substansi tetap).

## Ringkasan

- Total tier: 7 (T1–T7)
- Total task: 21 (3 task per tier: transformasi + verifikasi metrik + preservasi)
- Prompt master: 3 tahap (Tahap 1 NotebookLM, Tahap 2 OpenCode, Tahap 3 Claude)
- Verifikasi: §5.1 (panjang kalimat), §5.2 (sitasi), §5.3 (istilah Arab), §5.4 (hedging), §5.5 (audit `verify-tier.ps1`)

## Matriks Tier → Task → Owner

| Tier | Deskripsi | Task ID | Owner | Prioritas | Estimasi | Acceptance Criteria |
|---|---|---|---|---|---|---|
| T1 | Mahasiswa S1 (ID, makalah UAS) | TASK-T1-01 | Drafter | P0 | M | Draft Bab I–III tier T1, kalimat 15–25 kata, hedging T1 |
| T1 | Mahasiswa S1 (ID, makalah UAS) | TASK-T1-02 | Verifier | P0 | S | `verify-tier.ps1 -Tier T1` ≥ WARN membaik; regex sitasi diperbaiki |
| T1 | Mahasiswa S1 (ID, makalah UAS) | TASK-T1-03 | Reviewer | P0 | S | 100% sitasi + istilah Arab preserved (§5.2, §5.3) |
| T2 | Mahasiswa S2 (ID, tesis master) | TASK-T2-01 | Drafter | P1 | M | Upgrade T1→T2, kalimat 20–30 kata, deduktif + kontra |
| T2 | Mahasiswa S2 (ID, tesis master) | TASK-T2-02 | Verifier | P1 | S | `verify-tier.ps1 -Tier T2` PASS/WARN; densitas sitasi 0.5 |
| T2 | Mahasiswa S2 (ID, tesis master) | TASK-T2-03 | Reviewer | P1 | S | 100% sitasi + istilah Arab preserved (§5.2, §5.3) |
| T3 | Mahasiswa S3 (ID, disertasi) | TASK-T3-01 | Drafter | P1 | L | Upgrade T2→T3, kalimat 25–35 kata, sintesis multi-sumber + kontribusi orisinal |
| T3 | Mahasiswa S3 (ID, disertasi) | TASK-T3-02 | Verifier | P1 | S | `verify-tier.ps1 -Tier T3` PASS/WARN; densitas sitasi ~1 |
| T3 | Mahasiswa S3 (ID, disertasi) | TASK-T3-03 | Reviewer | P1 | M | 100% sitasi + istilah Arab preserved; tiap klaim besar ≥2 sumber |
| T4 | Akademisi Aktif (ID/EN, SINTA 1-2 / Scopus Q3-Q4) | TASK-T4-01 | Drafter | P1 | L | Upgrade T3→T4, kalimat 25–35 kata, gap riset + kontribusi teoretis eksplisit |
| T4 | Akademisi Aktif (ID/EN, SINTA 1-2 / Scopus Q3-Q4) | TASK-T4-02 | Verifier | P1 | S | `verify-tier.ps1 -Tier T4` PASS/WARN; densitas sitasi 1–2 |
| T4 | Akademisi Aktif (ID/EN, SINTA 1-2 / Scopus Q3-Q4) | TASK-T4-03 | Reviewer | P1 | M | 100% sitasi + istilah Arab preserved; metodologi eksplisit |
| T5 | Akademisi Senior (EN, Scopus Q1-Q2) | TASK-T5-01 | Drafter | P2 | L | Upgrade T4→T5, kalimat 20–30 kata, tiap paragraf berkontribusi, framing global |
| T5 | Akademisi Senior (EN, Scopus Q1-Q2) | TASK-T5-02 | Verifier | P2 | S | `verify-tier.ps1 -Tier T5` PASS/WARN; densitas sitasi 2–3 |
| T5 | Akademisi Senior (EN, Scopus Q1-Q2) | TASK-T5-03 | Reviewer | P2 | M | 100% sitasi + istilah Arab preserved; limitasi diakui jujur |
| T6 | Frontier (EN, Nature/Science/Cell) | TASK-T6-01 | Drafter | P2 | XL | Upgrade T5→T6, kalimat 15–25 kata padat, first-principles, implikasi lintas-disiplin |
| T6 | Frontier (EN, Nature/Science/Cell) | TASK-T6-02 | Verifier | P2 | M | `verify-tier.ps1 -Tier T6` PASS/WARN; densitas sitasi 3+ |
| T6 | Frontier (EN, Nature/Science/Cell) | TASK-T6-03 | Reviewer | P2 | M | 100% sitasi + istilah Arab preserved; angka/fakta langsung, zero fluff |
| T7 | Paradigm-Shifting (EN, position paper) | TASK-T7-01 | Drafter | P2 | XL | Reframe T1→T7 (genre berbeda, bukan upgrade linear), kalimat 10–20 kata, paradigm critique → reframing → agenda |
| T7 | Paradigm-Shifting (EN, position paper) | TASK-T7-02 | Verifier | P2 | M | `verify-tier.ps1 -Tier T7` PASS/WARN; densitas sitasi 2–3 + kritik |
| T7 | Paradigm-Shifting (EN, position paper) | TASK-T7-03 | Reviewer | P2 | M | 100% sitasi + istilah Arab preserved; tiap kalimat menantang asumsi |

Prioritas: P0 = fondasi (harus selesai dulu), P1 = inti nasional, P2 = internasional/frontier.
Estimasi: S ≤2 jam, M ≤1 hari, L ≤3 hari, XL ≤1 minggu.

## Detail Task per Tier

### T1 — Mahasiswa S1 (ID)

**TASK-T1-01:** Draft Bab I–III tier T1 (prompt master Tahap 2)
- Input: `PUSTAKA_INTI.md` (35 referensi) + `DRAFT_SKELETON.md` + prompt Tahap 2 (§4)
- Output: draft per bab (`makalah-hadis/draft/BAB_*_PARAFRASE.md`), register formal-akademik dasar, kalimat 15–25 kata, hedging "menurut X / hal ini menunjukkan", sitasi (Nama, Tahun) tiap klaim, istilah Arab italic
- Verifikasi: §5.5 (`verify-tier.ps1 -Tier T1`)
- Dependensi: tidak ada (fondasi)
- Skill requirement: `makalah-ceritas` (OpenCode)
- Good First Issue: yes

**TASK-T1-02:** Verifikasi metrik T1 + perbaikan regex sitasi
- Input: draft T1 + `scripts/verify-tier.ps1`
- Output: laporan metrik (panjang kalimat, sitasi/kalimat); **patch regex sitasi** agar mendeteksi `&`, `et al.`, grup `;` (temuan C9: 110 entri aktual hanya terdeteksi 2)
- Verifikasi: §5.1, §5.2
- Dependensi: TASK-T1-01
- Skill requirement: `makalah-ceritas` (scripts)
- Good First Issue: yes

**TASK-T1-03:** Audit preservasi T1 (sitasi + istilah Arab)
- Input: draft T1
- Output: laporan delta sitasi 0% + daftar istilah Arab hilang (target 0)
- Verifikasi: §5.2, §5.3
- Dependensi: TASK-T1-01
- Skill requirement: `makalah-ceritas`
- Good First Issue: yes

### T2 — Mahasiswa S2 (ID)

**TASK-T2-01:** Upgrade T1→T2 (prompt master Tahap 3, TARGET=T2)
- Input: draft T1 + karakteristik T2 (§3)
- Output: draft T2, register formal analitis, kalimat 20–30 kata, istilah teknis OK, tiap klaim + sitasi + alasan, struktur deduktif + counter-argument, hedging "mengindikasikan / menunjukkan / mengonfirmasi"
- Verifikasi: §5.5 (`verify-tier.ps1 -Tier T2`)
- Dependensi: TASK-T1-01
- Skill requirement: `makalah-ceritas` (Claude)
- Good First Issue: yes

**TASK-T2-02:** Verifikasi metrik T2
- Input: draft T2
- Output: laporan metrik; target kalimat 20–30, sitasi/kalimat ~0.5
- Verifikasi: §5.1, §5.2, §5.4
- Dependensi: TASK-T2-01
- Skill requirement: `makalah-ceritas` (scripts)
- Good First Issue: yes

**TASK-T2-03:** Audit preservasi T2
- Input: draft T1 vs T2
- Output: laporan delta sitasi 0% + istilah Arab 0 hilang
- Verifikasi: §5.2, §5.3
- Dependensi: TASK-T2-01
- Skill requirement: `makalah-ceritas`
- Good First Issue: no

### T3 — Mahasiswa S3 (ID)

**TASK-T3-01:** Upgrade T2→T3 (TARGET=T3)
- Input: draft T2 + karakteristik T3 (§3)
- Output: draft T3, register formal kritis, kalimat 25–35 kata, wajib sintesis multi-sumber, tiap klaim + kontra-klaim + resolusi, hedging "membuktikan / mengonfirmasi / mengoreksi", kontribusi orisinal per paragraf
- Verifikasi: §5.5 (`verify-tier.ps1 -Tier T3`)
- Dependensi: TASK-T2-01
- Skill requirement: `makalah-ceritas` (Claude)
- Good First Issue: no

**TASK-T3-02:** Verifikasi metrik T3
- Input: draft T3
- Output: laporan metrik; target kalimat 25–35, sitasi/kalimat ~1
- Verifikasi: §5.1, §5.2, §5.4
- Dependensi: TASK-T3-01
- Skill requirement: `makalah-ceritas` (scripts)
- Good First Issue: no

**TASK-T3-03:** Audit preservasi T3 + cek multi-sumber
- Input: draft T2 vs T3
- Output: delta sitasi 0% (tambah referensi konteks boleh, hapus tidak), istilah Arab 0 hilang, klaim besar ≥2 sumber
- Verifikasi: §5.2, §5.3
- Dependensi: TASK-T3-01
- Skill requirement: `makalah-ceritas`
- Good First Issue: no

### T4 — Akademisi Aktif (ID/EN)

**TASK-T4-01:** Upgrade T3→T4 (TARGET=T4)
- Input: draft T3 + karakteristik T4 (§3)
- Output: draft T4, register formal + spesialis, kalimat 25–35 kata, jargon OK, sitasi 1–2/kalimat, dialektis → sintesis, hedging "mengafirmasi / berkontribusi pada / melampaui", posisi di literatur + metodologi + gap + kontribusi dinyatakan
- Verifikasi: §5.5 (`verify-tier.ps1 -Tier T4`)
- Dependensi: TASK-T3-01
- Skill requirement: `makalah-ceritas` (Claude)
- Good First Issue: no

**TASK-T4-02:** Verifikasi metrik T4
- Input: draft T4
- Output: laporan metrik; target kalimat 25–35, sitasi/kalimat 1–2
- Verifikasi: §5.1, §5.2, §5.4
- Dependensi: TASK-T4-01
- Skill requirement: `makalah-ceritas` (scripts)
- Good First Issue: no

**TASK-T4-03:** Audit preservasi T4 + cek metodologi
- Input: draft T3 vs T4
- Output: delta sitasi 0%, istilah Arab 0 hilang, metodologi eksplisit dan dijustifikasi
- Verifikasi: §5.2, §5.3
- Dependensi: TASK-T4-01
- Skill requirement: `makalah-ceritas`
- Good First Issue: no

### T5 — Akademisi Senior (EN)

**TASK-T5-01:** Upgrade T4→T5 (TARGET=T5)
- Input: draft T4 + karakteristik T5 (§3)
- Output: draft T5 (EN), register formal + autoritatif, kalimat 20–30 kata efisien, tiap klaim NOVEL atau CORRECTIVE, sitasi 2–3/kalimat, multi-layer synthesis, hedging "reveals / demonstrates / revises", framing global, limitasi diakui
- Verifikasi: §5.5 (`verify-tier.ps1 -Tier T5`)
- Dependensi: TASK-T4-01
- Skill requirement: `makalah-ceritas` (Claude)
- Good First Issue: no

**TASK-T5-02:** Verifikasi metrik T5
- Input: draft T5
- Output: laporan metrik; target kalimat 20–30, sitasi/kalimat 2–3
- Verifikasi: §5.1, §5.2, §5.4
- Dependensi: TASK-T5-01
- Skill requirement: `makalah-ceritas` (scripts)
- Good First Issue: no

**TASK-T5-03:** Audit preservasi T5
- Input: draft T4 vs T5 (beda bahasa ID→EN: sitasi dan istilah Arab tetap Mahar)
- Output: delta sitasi 0%, istilah Arab italic 0 hilang
- Verifikasi: §5.2, §5.3
- Dependensi: TASK-T5-01
- Skill requirement: `makalah-ceritas`
- Good First Issue: no

### T6 — Frontier (EN)

**TASK-T6-01:** Upgrade T5→T6 (TARGET=T6)
- Input: draft T5 + karakteristik T6 (§3)
- Output: draft T6 (EN), register padat presisi, kalimat 15–25 kata, tiap kalimat = klaim / evidensi / interpretasi, sitasi 3+/kalimat, first-principles reasoning, hedging minimal ("shows / reveals / corrects"), implikasi lintas-disiplin eksplisit
- Verifikasi: §5.5 (`verify-tier.ps1 -Tier T6`)
- Dependensi: TASK-T5-01
- Skill requirement: `makalah-ceritas` (Claude) + riset domain
- Good First Issue: no

**TASK-T6-02:** Verifikasi metrik T6
- Input: draft T6
- Output: laporan metrik; target kalimat 15–25, sitasi/kalimat 3+
- Verifikasi: §5.1, §5.2, §5.4
- Dependensi: TASK-T6-01
- Skill requirement: `makalah-ceritas` (scripts)
- Good First Issue: no

**TASK-T6-03:** Audit preservasi T6
- Input: draft T5 vs T6
- Output: delta sitasi 0%, istilah Arab 0 hilang, zero fluff
- Verifikasi: §5.2, §5.3
- Dependensi: TASK-T6-01
- Skill requirement: `makalah-ceritas`
- Good First Issue: no

### T7 — Paradigm-Shifting (EN)

> Catatan §3: T7 is NOT "higher than T6" — it is a DIFFERENT genre (position paper / manifesto / editorial).

**TASK-T7-01:** Reframe T1→T7 (TARGET=T7)
- Input: draft T1 + karakteristik T7 (§3)
- Output: draft T7 (EN), register provokatif visioner, kalimat 10–20 kata punchy, tiap kalimat menantang asumsi, tiap klaim = reframing konseptual, struktur paradigm critique → reframing → agenda, near-zero hedging ("we reformulate / we challenge")
- Verifikasi: §5.5 (`verify-tier.ps1 -Tier T7`)
- Dependensi: TASK-T1-01 (langsung dari T1, bukan dari T6)
- Skill requirement: `makalah-ceritas` (Claude) + riset domain
- Good First Issue: no

**TASK-T7-02:** Verifikasi metrik T7
- Input: draft T7
- Output: laporan metrik; target kalimat 10–20, sitasi/kalimat 2–3 + kritik
- Verifikasi: §5.1, §5.2, §5.4
- Dependensi: TASK-T7-01
- Skill requirement: `makalah-ceritas` (scripts)
- Good First Issue: no

**TASK-T7-03:** Audit preservasi T7
- Input: draft T1 vs T7
- Output: sitasi inti dipertahankan (genre position paper boleh selektif, tetapi tidak boleh memalsukan), istilah Arab kunci dipertahankan
- Verifikasi: §5.2, §5.3
- Dependensi: TASK-T7-01
- Skill requirement: `makalah-ceritas`
- Good First Issue: no

## Matriks Task → Verifikasi Script

| Task ID | Skrip verifikasi | Metrik target |
|---|---|---|
| TASK-T1-01 | `verify-tier.ps1 -Tier T1` | 15–25 kata/kalimat, 0.3–0.5 sitasi/kalimat |
| TASK-T1-02 | `verify-tier.ps1 -Tier T1` + §5.1/§5.2 manual | regex sitasi deteksi `&`, `et al.`, `;` |
| TASK-T1-03 | §5.2 + §5.3 (banding asal vs target) | delta sitasi 0%, istilah hilang 0 |
| TASK-T2-01 | `verify-tier.ps1 -Tier T2` | 20–30 kata/kalimat, ~0.5 sitasi/kalimat |
| TASK-T2-02 | `verify-tier.ps1 -Tier T2` + §5.4 | hedging T2: mengindikasikan/menunjukkan |
| TASK-T2-03 | §5.2 + §5.3 | delta 0%, hilang 0 |
| TASK-T3-01 | `verify-tier.ps1 -Tier T3` | 25–35 kata/kalimat, ~1 sitasi/kalimat |
| TASK-T3-02 | `verify-tier.ps1 -Tier T3` + §5.4 | hedging T3: membuktikan/mengonfirmasi |
| TASK-T3-03 | §5.2 + §5.3 | delta 0%, hilang 0, klaim besar ≥2 sumber |
| TASK-T4-01 | `verify-tier.ps1 -Tier T4` | 25–35 kata/kalimat, 1–2 sitasi/kalimat |
| TASK-T4-02 | `verify-tier.ps1 -Tier T4` + §5.4 | hedging T4: mengafirmasi/berkontribusi |
| TASK-T4-03 | §5.2 + §5.3 | delta 0%, hilang 0, metodologi eksplisit |
| TASK-T5-01 | `verify-tier.ps1 -Tier T5` | 20–30 kata/kalimat, 2–3 sitasi/kalimat |
| TASK-T5-02 | `verify-tier.ps1 -Tier T5` + §5.4 | hedging T5: reveals/demonstrates/revises |
| TASK-T5-03 | §5.2 + §5.3 | delta 0%, hilang 0 |
| TASK-T6-01 | `verify-tier.ps1 -Tier T6` | 15–25 kata/kalimat, 3+ sitasi/kalimat |
| TASK-T6-02 | `verify-tier.ps1 -Tier T6` + §5.4 | hedging minimal: shows/reveals/corrects |
| TASK-T6-03 | §5.2 + §5.3 | delta 0%, hilang 0 |
| TASK-T7-01 | `verify-tier.ps1 -Tier T7` | 10–20 kata/kalimat, 2–3 sitasi/kalimat + kritik |
| TASK-T7-02 | `verify-tier.ps1 -Tier T7` + §5.4 | near-zero hedging: we reformulate/challenge |
| TASK-T7-03 | §5.2 + §5.3 | sitasi inti kept, istilah kunci kept |

## Urutan Eksekusi (Dependency Order)

1. **Fase Alpha: T1, T2** — fondasi. Draft T1 (TASK-T1-01) dulu; lalu verifikasi + preservasi T1 (TASK-T1-02, TASK-T1-03) paralel; lalu upgrade T2 (TASK-T2-01) + verifikasi/preservasi T2.
2. **Fase Beta: T3, T4** — pendalaman nasional. Berurutan T3 → T4 (tiap tier: transformasi → verifikasi → preservasi).
3. **Fase Launch: T5, T6, T7** — internasional. T5 → T6 berurutan (dependensi linear); T7 paralel dari T1 (genre berbeda, tidak menunggu T6).

```
T1-01 ─┬─► T1-02 ─┬─► T2-01 ─► T2-02/T2-03 ─► T3-01 ─► … ─► T4 ─► T5-01 ─► T6-01 ─► T6-02/T6-03
       └─► T1-03 ─┘                              └─► T7-01 ─► T7-02/T7-03 (paralel, dari T1)
```

Toleransi panjang tiap transformasi: ±15% dari naskah asal (§4 prompt Tahap 3).

## Label OpenCode

- `good-first-issue`: TASK-T1-01, TASK-T1-02, TASK-T1-03, TASK-T2-01, TASK-T2-02
- `needs-research`: TASK-T5-01, TASK-T6-01, TASK-T6-02, TASK-T7-01, TASK-T7-02
- `blocked`: (tidak ada saat ini — T5–T7 terblokir sampai Fase Alpha selesai, status akan diperbarui saat eksekusi)
