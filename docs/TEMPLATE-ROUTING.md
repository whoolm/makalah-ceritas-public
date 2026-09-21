# Template Routing Guide

> Panduan memilih template LaTeX per matkul berdasarkan bidang ilmu.

## Matriks Keputusan

| Bidang | Template | Alasan |
|---|---|---|
| **Eksakta/Matematis** (Matematika, Fisika, Ilmu Falak, Statistik) | `elsevier` | 1-kolom, rumus leluasa, referensi numerik |
| **Sosial/Humaniora** (Hukum, Sosiologi, Politik, Ekonomi) | `ieee` | 2-kolom, sitasi APA, format jurnal |
| **Keislaman/Teks** (Ulumul Hadis, Ulumul Qur'an, Fiqih) | `makalah` | 7 bagian, sitasi footnote, kutipan Arab |
| **Log/Q&A Mingguan** (Fiqih log, tugas mingguan) | `log-mingguan` | Q&A per materi, footnote, tanpa cover |

## Mapping Detail per Matkul (Existing)

| Matkul | Kode | Bidang | Template |
|---|---|---|---|
| PIH | 01 | Hukum | ieee |
| Ulumul Hadis | 02 | Hadis | makalah |
| Moderasi | 03 | Sosial-Keislaman | makalah |
| Ilmu Fiqih | 04 | Fiqih | log-mingguan |
| Ilmu Falak | 05+ | Eksakta | elsevier |
| Filsafat | 06+ | Humaniora | ieee |

## Keyword → Template (Auto-Detect)

```js
const TEMPLATE_BY_KEYWORD = {
  // Eksakta / Matematis → elsevier
  elsevier: ['matematika', 'fisika', 'statistik', 'ilmu falak',
             'astronomi', 'kimia', 'biologi', 'algoritma', 'kalkulus'],

  // Sosial/Humaniora → ieee
  ieee: ['hukum', 'sosiologi', 'politik', 'ekonomi', 'pancasila',
         'kewarganegaraan', 'filsafat', 'psikologi'],

  // Keislaman/Teks → makalah
  makalah: ['hadis', 'qur\'an', 'tafsir', 'akidah', 'tasawuf',
            'moderasi', 'sejarah islam', 'fiqih', 'ushul fiqih'],

  // Log mingguan → log-mingguan
  'log-mingguan': ['log', 'mingguan', 'tugas harian', 'jurnal'],
};
```

## Cara Pakai

### Cara 1 — Manual (sekarang)
Set di `config.md`:
```yaml
overrides:
  01: {template: ieee}
```

### Cara 2 — Auto-detect (kalau di-enable)
Set `auto_template: true` di config global:
```yaml
auto_template: true
```
Config.js akan baca nama matkul, cari keyword, auto-pick template.

## Contoh Keputusan
- "Ilmu Fiqih" → mengandung "fiqih" → `log-mingguan` (override manual, prioritas)
- "Matematika Diskrit" → mengandung "matematika" → `elsevier`
- "Hukum Pidana" → mengandung "hukum" → `ieee`
- "Ulumul Hadis" → mengandung "hadis" → `makalah`
