# COVER PROMPT — Template Default

> Prompt untuk generate cover page (via ChatGPT/DALL-E, Midjourney, Canva AI, dll).
> Copy-paste, ganti placeholder `{...}` sesuai matkul.

---

## SPESIFIKASI TEKNIS

- Ukuran: **2480 × 3508 px** (A4 @ 300 DPI)
- Format: **PNG**
- Orientation: Portrait
- Aspect ratio: 1:1.414
- Color: RGB

---

## PROMPT DEFAULT (bahasa Inggris, untuk AI image generator)

```
A formal academic cover page for a university paper, portrait orientation,
A4 aspect ratio, ultra high resolution 2480x3508 pixels.

TITLE (large, top 30%):
"{PAPER_TITLE}"

AUTHORS (center, 55%):
{PAPER_AUTHORS}

INSTITUTION (below authors, 65%):
{PAPER_INSTITUTION}

YEAR (bottom center, 90%):
{YEAR}

BOTTOM LOGOS (three columns at bottom, 85%):
Left: UIN Walisongo Semarang logo
Center: Faculty of Sharia and Law logo
Right: {STUDENT_ASSOCIATION} logo

STYLE:
- Heritage Indonesian academic aesthetic
- Sepia / gold / cream color palette
- Background: {VISUAL_THEME}
- Border: subtle Islamic geometric patterns or batik motifs
- Typography: elegant serif (Playfair Display, Trajan, Garamond)
- Clean, formal, dignified

FORMAT:
- Portrait A4 ratio
- 2480 x 3508 pixels
- PNG format
- No watermark, no signature

Generate 2-3 variants, I will choose one.
```

---

## CONTOH PENGISIAN

### Cover PIH (Hukum dan Hak)

```
{PAPER_TITLE}         = "HUKUM DAN HAK: RELASI RESIPROKAL DALAM KERANGKA NEGARA HUKUM INDONESIA BERDASARKAN UUD 1945"
{PAPER_AUTHORS}       = "Tri Salman Bayu Ramadhan (26020460020) | M. Fakhri Fairus Zain (26020460021)"
{PAPER_INSTITUTION}   = "Program Studi Ilmu Falak, Fakultas Syariah dan Hukum, UIN Walisongo Semarang"
{YEAR}                = "2026"
{STUDENT_ASSOCIATION} = "HMJ IF"
{VISUAL_THEME}        = "classical law court, scales of justice, old law books, subtle Islamic geometric pattern"
```

### Cover Moderasi Beragama

```
{PAPER_TITLE}         = "MODERASI BERAGAMA: {judul topik}"
{PAPER_AUTHORS}       = "Tri Salman (26020460020) | {co-author}"
{PAPER_INSTITUTION}   = "Program Studi Ilmu Falak, FSH, UIN Walisongo Semarang"
{YEAR}                = "2026"
{VISUAL_THEME}        = "interfaith harmony, mosque + church + temple silhouette, hands clasped, Indonesian map"
```

### Cover Ulumul Hadis

```
{PAPER_TITLE}         = "ULUMUL HADIS: {judul topik}"
{VISUAL_THEME}        = "old Arabic manuscripts, calligraphy, chain of narration (sanad) motif, desert"
```

### Cover Ilmu Fiqih (log-mingguan)

```
{PAPER_TITLE}         = "TUGAS ILMU FIQIH: {judul materi}"
{VISUAL_THEME}        = "Islamic jurisprudence, Q&A dialogue, traditional kitab, prayer niche"
```

---

## PALETTE (sesuai design-default.md)

### Primary Palette (WAJIB)

Sumber: `design-default.md` v1.0 (Makalah Ceritas Design System).

- Primary: `#059669` (emerald, formal akademik — dipakai sebagai accent cover)
- Secondary: `#6B7280` (gray-500, teks pendukung cover)
- Neutral/Text: `#0F172A` (slate dark, teks utama cover)
- Success: `#10B981` (emerald-500)
- Warning: `#F59E0B` (amber-500)
- Danger: `#EF4444` (red-500)
- Background cover: `#FDF9F0` (cream netral, kompatibel dengan primary emerald)
- Secondary accent cover: `#C9A961` (gold, pendamping primary `#059669`)

### Typography (sesuai design-default.md)

- Serif (design: Public Serif) → cover: Playfair Display / Garamond / Trajan
  (Title 48-72 pt bold, Subtitle 24-32 pt regular)
- Sans (design: Public Sans) → cover: Inter / sistem sans
  (Author 18-24 pt, Institution 14-18 pt)

### Variasi Cover (opsional per matkul)

Turunan dari primary `#059669` — tetap dalam satu brand family.

#### A. Heritage Sepia (seperti Pancasila/PIH)

- Sepia: `#8B6F47` / `#D4A574` (turun dari primary — tone hangat)
- Cream: `#F5E6D3` / `#FDF9F0` (background, sama dengan background cover design system)
- Gold accent: `#C9A961` (secondary accent cover)
- Text: `#0F172A` (neutral design system; alternatif hangat `#3D2E1F` bila background sepia pekat)

#### B. Formal Blue (akademik)

- Navy: `#1E3A5F` / `#0F1E33` (varian formal; accent utama tetap `#059669` bila perlu brand consistency)
- Gold: `#C9A961` / `#D4AF37` (secondary accent cover)
- White: `#FFFFFF` / `#F8F8F8`
- Text: `#FFFFFF` (di atas navy) / `#0F172A` (di atas terang, sesuai neutral design system)

#### C. Green Islamic (paling dekat dengan primary)

- Emerald: `#059669` (primary design system, WAJIB sebagai base) / varian pekat `#0E5C3F` / `#046A38` untuk background pekat
- Gold: `#C9A961` (secondary accent cover)
- Cream: `#F0E8D5` / `#FDF9F0`
- Text: `#0F172A` (neutral design system; `#1A1A1A` hanya bila butuh kontras di atas cream)

---

## CARA PAKAI

1. **Copy prompt default** di atas
2. **Ganti placeholder** dengan data matkul Anda
3. **Paste ke AI generator**:
   - ChatGPT dengan DALL-E 3 (paling gampang)
   - Midjourney (paling bagus visual)
   - Canva AI (paling custom)
   - Bing Image Creator (gratis)
4. **Download** PNG 2480×3508
5. **Resize** kalau perlu (via Photoshop/Paint/GIMP)
6. **Rename** sesuai konvensi:
   - PIH → `cover_pih.png`
   - Moderasi → `cover_moderasi.png`
   - Ulumul Hadis → `cover_hadis.png`
   - Fiqih → `cover_fiqih.png`
7. **Taruh** di folder output topik:
   `D:\Ceritas-Batch\output\matkul-XX\topik-YY\cover_XXX.png`

---

## TIPS

- **Jangan pakai file cover Pancasila** — itu cover PANCASILA, bukan untuk PIH/Moderasi/dll
- **Preview resolusi**: cek `Get-Item cover.png | Select LastWriteTime` + `pdfinfo` untuk verify
- **Kalau AI generate tidak puas**: gunakan Canva template akademik → customize
- **Konsistensi**: pakai palette yang sama untuk semua cover matkul (brand consistency)
- **Backup**: simpan master cover di `D:\Ceritas-Batch\covers\` sebelum copy ke folder output

---

## LOGO SUMBER (kalau perlu)

- UIN Walisongo: https://walisongo.ac.id (logo resmi)
- FSH: Fakultas Syariah dan Hukum
- HMJ IF: Himpunan Mahasiswa Jurusan Ilmu Falak

Cek di folder `D:\Ceritas-Batch\assets\logos\` (kalau ada) atau dari website resmi.
