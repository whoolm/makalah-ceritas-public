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
    Write-Host "WARN: Panjang kalimat di luar target" -ForegroundColor Yellow
    $status = "WARN"
}
if ($citPerSentence -lt $t.MinCit -or $citPerSentence -gt $t.MaxCit) {
    Write-Host "WARN: Sitasi density di luar target" -ForegroundColor Yellow
    $status = "WARN"
}

Write-Host ""
Write-Host "Status: $status" -ForegroundColor $(if ($status -eq "PASS") { "Green" } else { "Yellow" })
