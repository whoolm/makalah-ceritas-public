# PARAFRASE TIERS — 7 Tingkat Gaya Akademik

> Referensi resmi untuk pipeline parafrase makalah Ceritas.
> Setiap tier = transformasi STYLE, bukan CONTENT (fakta, sitasi, substansi tetap).
> Versi: 1.0 — 17 Sep 2026

## 1. Daftar Tier

| Kode | Nama | Target Audiens | Bahasa | Contoh Konteks |
|---|---|---|---|---|
| T1 | Mahasiswa S1 | Dosen mata kuliah | ID | Makalah UAS |
| T2 | Mahasiswa S2 | Penguji tesis | ID | Tesis master |
| T3 | Mahasiswa S3 | Penguji disertasi | ID | Disertasi doktoral |
| T4 | Akademisi Aktif | SINTA 1-2, Scopus Q3-Q4 | ID/EN | Artikel jurnal nasional |
| T5 | Akademisi Senior | Scopus Q1-Q2 | EN | Artikel internasional |
| T6 | Frontier | Nature/Science/Cell | EN | Riset top-tier global |
| T7 | Paradigm-Shifting | Position paper | EN | Manifesto/editorial |

## 2. Karakteristik Per Tier

| Fitur | T1 | T2 | T3 | T4 | T5 | T6 | T7 |
|---|---|---|---|---|---|---|---|
| Register | Formal dasar | Formal analitis | Formal kritis | Formal spesialis | Formal autoritatif | Padat presisi | Provokatif visioner |
| Panjang kalimat | 15-25 | 20-30 | 25-35 | 25-35 | 20-30 | 15-25 | 10-20 |
| Kepadatan leksikal | Sedang | Sedang-tinggi | Tinggi | Tinggi + jargon | Tinggi presisi | Sangat tinggi | Tinggi + metafora |
| Hedging khas | "dapat dikatakan", "menurut" | "mengindikasikan", "menunjukkan" | "membuktikan", "mengonfirmasi" | "mengafirmasi", "berkontribusi" | "mengungkap", "merevisi" | "menyingkap", "mengoreksi" | "menantang", "merumuskan ulang" |
| Sitasi per kalimat | 0.3-0.5 | 0.5 | 1 | 1-2 | 2-3 | 3+ | 2-3 + kritik |
| Struktur argumen | Deduktif | Deduktif + kontra | Dialektis | Dialektis + sintesis | Multi-layer | First-principles | Paradigm critique |

## 3. Prompt Per Tier (ID + EN)

### T1 — Mahasiswa S1 (ID)

**Peran:** Editor akademik untuk tugas kuliah mahasiswa S1.

**Aturan gaya:**
- Register: formal-akademik dasar
- Panjang kalimat: 15-25 kata
- Hindari jargon spesialis, pakai istilah umum akademik
- Setiap klaim didukung sitasi (Nama, Tahun)
- Struktur: kalimat topik → elaborasi → sintesis
- Hedging: "dapat dikatakan", "menurut X", "hal ini menunjukkan"

**Dilarang:** istilah teknis tanpa penjelasan; kalimat >30 kata; asumsi pembaca tahu konsep dasar.

**Contoh transformasi:**
- Sebelum: "Ontologi monodualis-monopluralis mengafirmasi relasionalitas konstitutif subjek."
- Sesudah: "Menurut Notonagoro (1975), manusia adalah makhluk monodualis — ia individu sekaligus sosial, jasmani sekaligus rohani. Pandangan ini menunjukkan bahwa manusia tidak dapat dipahami secara terpisah dari relasinya."

### T2 — Mahasiswa S2 (ID)

**Peran:** Editor akademik untuk tesis master.

**Aturan gaya:**
- Register: formal analitis
- Panjang kalimat: 20-30 kata
- Istilah teknis OK (dengan glosarium jika perlu)
- Setiap klaim + sitasi + alasan
- Struktur: deduktif + counter-argument
- Hedging: "mengindikasikan", "menunjukkan", "mengonfirmasi"

**Dilarang:** klaim tanpa dukungan; generalisasi tanpa data; bahasa populer.

**Contoh:**
- Sebelum: "Pancasila itu penting."
- Sesudah: "Pancasila menempati posisi sentral dalam arsitektur hukum Indonesia, sebagaimana diargumentasikan Latif (2018) yang menunjukkan bahwa nilai-nilainya menjadi sumber legitimasi seluruh norma di bawahnya."

### T3 — Mahasiswa S3 (ID)

**Peran:** Editor akademik untuk disertasi doktoral.

**Aturan gaya:**
- Register: formal kritis
- Panjang kalimat: 25-35 kata
- Wajib sintesis multi-sumber
- Setiap klaim + kontra-klaim + resolusi
- Hedging: "membuktikan", "mengonfirmasi", "mengoreksi"
- Wajib kontribusi orisinal di setiap paragraf

**Dilarang:** satu sumber untuk klaim besar; tidak ada posisi penulis; deskripsi tanpa analisis.

**Contoh:**
- Sebelum: "Pancasila adalah jalan tengah."
- Sesudah: "Tesis 'jalan tengah' Pancasila tidak dapat diterima tanpa kualifikasi: sebagaimana ditunjukkan Madung (2016) dan Duha (2022), posisi ini kredibel hanya jika disertai konsistensi praktik negara. Tanpa itu, klaim tersebut runtuh menjadi retorika legitimasi."

### T4 — Akademisi Aktif (ID/EN)

**Peran:** Editor untuk jurnal nasional terakreditasi (SINTA 1-2).

**Aturan gaya:**
- Register: formal + spesialis
- Panjang kalimat: 25-35 kata
- Jargon spesialis OK
- Sitasi density: 1-2 per kalimat
- Struktur: dialektis → sintesis
- Hedging: "mengafirmasi", "berkontribusi pada", "melampaui"

**Ciri khas:** posisi jelas di literatur; metodologi eksplisit; gap riset dirumuskan; kontribusi teoretis dinyatakan.

**Contoh:**
- Sebelum: "Penelitian ini membahas Pancasila."
- Sesudah: "Artikel ini berkontribusi pada literatur filsafat politik Indonesia dengan merekonstruksi Pancasila sebagai sistem filsafat sistematis — melampaui pembacaan normatif yang dominan (Latif, 2018) dan kritik post-foundational yang cenderung reduktif (Kim, 2024)."

### T5 — Akademisi Senior (EN)

**Role:** Editor for high-impact international journal (Scopus Q1-Q2).

**Style rules:**
- Register: formal + authoritative
- Sentence length: 20-30 words (efficient, no verbosity)
- Every claim must be NOVEL or CORRECTIVE
- Citation density: 2-3 per sentence
- Structure: multi-layer synthesis
- Hedging: "reveals", "demonstrates", "revises"

**Distinctive features:** every paragraph carries contribution; direct dialogue with literature; methodology justified against alternatives; limitations honestly acknowledged; global framing (not local-centric).

**Example:**
- Before: "Many scholars discuss Pancasila."
- After: "Although the literature on Pancasila has long been dominated by normative-historical readings (Latif, 2018; Madung, 2016), this dominant framework fails to explain why Pancasila's symbolic resilience coexists with its substantive fragility (CSIS, 2023). We argue that this failure stems from an ontological reduction that ignores Pancasila's relational-religious dimension."

### T6 — Frontier (EN)

**Role:** Editor for top-tier global journal (Nature/Science/Cell level).

**Style rules:**
- Register: dense + precise
- Sentence length: 15-25 words (dense, zero fluff)
- Every sentence = claim / evidence / interpretation
- Citation density: 3+ per sentence
- Structure: first-principles reasoning
- Minimal hedging: "shows", "reveals", "corrects"

**Distinctive features:** economical language; numbers/facts stated directly; universal framing; cross-disciplinary implications explicit; data visualization referenced.

**Example:**
- Before: "Pancasila is still relevant today."
- After: "Pancasila remains relevant on three structural grounds: (i) its relational ontology transcends Cartesian dualism; (ii) its deliberative epistemology corrects the limitations of rationalism and empiricism; (iii) its justice axiology addresses the intergenerational-ecological crisis (Latif, 2018; Madung, 2016; Yusa, 2022). These three operate as one system — not three separate claims."

### T7 — Paradigm-Shifting (EN)

**Role:** Editor for position paper that challenges paradigms.

**Style rules:**
- Register: provocative + visionary
- Sentence length: 10-20 words (punchy)
- Every sentence must challenge an assumption
- Every claim = conceptual reframing
- Structure: paradigm critique → reframing → agenda
- Near-zero hedging: "we reformulate", "we challenge"

**Distinctive features:** challenges established categories; reformulates questions (not answers); conceptual metaphor used sparingly; new research agenda formulated; short impactful sentences.

**Note:** This mode is NOT "higher than T6" — it is a DIFFERENT genre. Suited for position papers, scientific manifestos, or journal editorials.

**Example:**
- Before: "Pancasila is a philosophical system."
- After: "The question 'is Pancasila a philosophical system?' is wrongly posed. Pancasila is not a system — it is a contested field. Each generation refills it, and therein lies its strength. Our task is not to freeze interpretation, but to sustain the space of debate."

## 4. Prompt Master — Integrasi 3 AI (OpenCode + Claude + NotebookLM)

### Pipeline 3 Tahap

```
┌────────────────────────────────────────────────────┐
│ TAHAP 1 — NotebookLM (ekstraksi konten)            │
│   Upload sumber → Gap Analysis → outline + refs    │
│   Tier-agnostic (fokus konten)                     │
└──────────────────────┬─────────────────────────────┘
                       ▼
┌────────────────────────────────────────────────────┐
│ TAHAP 2 — OpenCode (draft + parafrase T1)          │
│   Generate draft Bab I-III di tier T1              │
│   Preserve: sitasi, istilah Arab, heading          │
└──────────────────────┬─────────────────────────────┘
                       ▼
┌────────────────────────────────────────────────────┐
│ TAHAP 3 — Claude (upgrade tier)                    │
│   Draft T1 → T4/T5/T6/T7 sesuai target             │
│   Preserve: 100% sitasi + istilah Arab             │
│   Change: hanya style (register, hedging, density) │
└──────────────────────┬─────────────────────────────┘
                       ▼
┌────────────────────────────────────────────────────┐
│ VERIFIKASI OTOMATIS                                │
│   Skrip PowerShell cek panjang, sitasi, istilah    │
└────────────────────────────────────────────────────┘
```

### Prompt Tahap 1 — NotebookLM (Tier-agnostic)

```
Peran Anda: reviewer akademik senior.

Tugas: analisis GAP RISET dari seluruh makalah yang saya upload.

Langkah:
1. Identifikasi TOPIK UTAMA yang dibahas.
2. Klasifikasikan: jenuh / diperdebatkan / belum tergarap.
3. Untuk topik belum tergarap: kenapa gap, metode rekomendasi, sitasi terdekat.
4. Ranking berdasarkan urgensi, eksekusi, kontribusi.

Output: tabel + narasi ringkas.
```

### Prompt Tahap 2 — OpenCode (Draft T1)

```
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

### Prompt Tahap 3 — Claude (Upgrade Tier)

```
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

## 5. Verifikasi Otomatis — Skrip PowerShell

### 5.1 Cek Panjang Kalimat Rata-Rata

```powershell
function Get-AvgSentenceLength($filePath) {
    $text = Get-Content $filePath -Raw
    # Split per kalimat (., !, ?)
    $sentences = $text -split '(?<=[.!?])\s+' | Where-Object { $_.Trim().Length -gt 10 }
    $totalWords = ($text -split '\s+').Count
    $totalSentences = $sentences.Count
    if ($totalSentences -eq 0) { return 0 }
    return [math]::Round($totalWords / $totalSentences, 1)
}

# Contoh pemakaian
$files = Get-ChildItem "draft\*_TIER-*.md"
foreach ($f in $files) {
    $avg = Get-AvgSentenceLength $f.FullName
    Write-Host "$($f.Name): $avg kata/kalimat"
}
```

### 5.2 Cek Sitasi Preserved

```powershell
function Get-CitationCount($filePath) {
    $text = Get-Content $filePath -Raw
    $cites = [regex]::Matches($text, '\([A-Z][a-zA-Z\s\.]+?,?\s+\d{4}\)')
    return $cites.Count
}

# Bandingkan tier asal vs tier target
$asal = Get-CitationCount "draft\BAB_I_T1.md"
$target = Get-CitationCount "draft\BAB_I_T5.md"
Write-Host "T1: $asal sitasi"
Write-Host "T5: $target sitasi"
Write-Host "Delta: $($target - $asal) ($([math]::Round(($target-$asal)/$asal*100,1))%)"
# Target: 0% (harus sama)
```

### 5.3 Cek Istilah Arab Preserved

```powershell
function Get-ArabicTerms($filePath) {
    $text = Get-Content $filePath -Raw
    $terms = [regex]::Matches($text, '\*[a-z\-]+\*')
    return ($terms | ForEach-Object { $_.Value } | Sort-Object -Unique)
}

$asalTerms = Get-ArabicTerms "draft\BAB_I_T1.md"
$targetTerms = Get-ArabicTerms "draft\BAB_I_T5.md"

$missing = $asalTerms | Where-Object { $_ -notin $targetTerms }
Write-Host "Istilah Arab hilang: $($missing.Count)"
$missing | ForEach-Object { Write-Host "  MISSING: $_" }
# Target: 0
```

### 5.4 Cek Hedging Density (per tier)

```powershell
function Get-HedgingDensity($filePath, $tier) {
    $text = Get-Content $filePath -Raw
    $words = ($text -split '\s+').Count

    $hedging = @{
        "T1" = @("dapat dikatakan", "menurut", "hal ini menunjukkan")
        "T2" = @("mengindikasikan", "menunjukkan", "mengonfirmasi")
        "T3" = @("membuktikan", "mengonfirmasi", "mengoreksi")
        "T4" = @("mengafirmasi", "berkontribusi", "melampaui")
        "T5" = @("mengungkap", "merevisi", "mendemonstrasikan")
        "T6" = @("menyingkap", "mengoreksi", "menunjukkan")
        "T7" = @("menantang", "merumuskan ulang")
    }

    $targetHedging = $hedging[$tier]
    $count = 0
    foreach ($h in $targetHedging) {
        $count += ([regex]::Matches($text, [regex]::Escape($h))).Count
    }

    $density = [math]::Round(($count / $words) * 100, 2)
    return @{ Count = $count; Density = $density }
}

# Contoh
$result = Get-HedgingDensity "draft\BAB_I_T5.md" "T5"
Write-Host "Hedging density: $($result.Density)% ($($result.Count) instances)"
# Target T5: 0.5-1.5%
```

### 5.5 Skrip Lengkap — Audit Tier

Buat file `scripts\verify-tier.ps1`:

```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath,

    [Parameter(Mandatory=$true)]
    [ValidateSet('T1','T2','T3','T4','T5','T6','T7')]
    [string]$Tier
)

Write-Host "=== AUDIT TIER $Tier ===" -ForegroundColor Cyan
Write-Host "File: $FilePath`n"

if (-not (Test-Path $FilePath)) {
    Write-Host "ERROR: File tidak ditemukan" -ForegroundColor Red
    exit 1
}

$text = Get-Content $FilePath -Raw
$words = ($text -split '\s+').Count
$sentences = ($text -split '(?<=[.!?])\s+').Count
$avgSentence = [math]::Round($words / $sentences, 1)
$citations = ([regex]::Matches($text, '\([A-Z][a-zA-Z\s\.]+?,?\s+\d{4}\)')).Count

# Target per tier
$targets = @{
    "T1" = @{ MinSentence = 15; MaxSentence = 25; MinCit = 0.3; MaxCit = 0.5 }
    "T2" = @{ MinSentence = 20; MaxSentence = 30; MinCit = 0.5; MaxCit = 0.7 }
    "T3" = @{ MinSentence = 25; MaxSentence = 35; MinCit = 0.8; MaxCit = 1.2 }
    "T4" = @{ MinSentence = 25; MaxSentence = 35; MinCit = 1.0; MaxCit = 2.0 }
    "T5" = @{ MinSentence = 20; MaxSentence = 30; MinCit = 2.0; MaxCit = 3.0 }
    "T6" = @{ MinSentence = 15; MaxSentence = 25; MinCit = 3.0; MaxCit = 5.0 }
    "T7" = @{ MinSentence = 10; MaxSentence = 20; MinCit = 2.0; MaxCit = 3.0 }
}

$t = $targets[$Tier]
$citPerSentence = [math]::Round($citations / $sentences, 2)

Write-Host "Total kata: $words"
Write-Host "Total kalimat: $sentences"
Write-Host "Rata-rata panjang kalimat: $avgSentence kata (target: $($t.MinSentence)-$($t.MaxSentence))"
Write-Host "Total sitasi: $citations"
Write-Host "Sitasi per kalimat: $citPerSentence (target: $($t.MinCit)-$($t.MaxCit))"
Write-Host ""

$status = "PASS"
if ($avgSentence -lt $t.MinSentence -or $avgSentence -gt $t.MaxSentence) {
    Write-Host "⚠️ Panjang kalimat di luar target" -ForegroundColor Yellow
    $status = "WARN"
}
if ($citPerSentence -lt $t.MinCit -or $citPerSentence -gt $t.MaxCit) {
    Write-Host "⚠️ Sitasi density di luar target" -ForegroundColor Yellow
    $status = "WARN"
}

Write-Host ""
Write-Host "Status: $status" -ForegroundColor $(if ($status -eq "PASS") { "Green" } else { "Yellow" })
```

Pemakaian:
```powershell
.\scripts\verify-tier.ps1 -FilePath "draft\BAB_I_T5.md" -Tier "T5"
```

## 6. Cheat Sheet — Pilih Tier dalam 10 Detik

| Situasi Anda | Tier |
|---|---|
| Tugas UAS / makalah mata kuliah | **T1** |
| Tesis master | **T2** |
| Disertasi doktoral | **T3** |
| Submit ke SINTA 1-2 / Scopus Q3-Q4 | **T4** |
| Submit ke Scopus Q1-Q2 | **T5** |
| Submit ke Nature/Science | **T6** |
| Position paper / editorial | **T7** |

## 7. Integrasi ke Pipeline Proyek

**F3 Drafting:** Draft T1 (OpenCode)
**F4 Parafrase:** Upgrade tier via Claude
**Verifikasi:** Skrip `verify-tier.ps1`
**F5-F6:** Footnote + compile (tier-agnostic)

Prompt di `PROMPT_CATALOG.md` §5 (Parafrase) — tambahkan referensi ke file ini.
