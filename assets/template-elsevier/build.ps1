# Build script untuk Windows PowerShell
# Cara pakai: .\build.ps1

$Paper = "template_elsevier"
$Bib   = "referensi_template"

Write-Host "==> Pass 1: pdflatex" -ForegroundColor Cyan
pdflatex -interaction=nonstopmode "$Paper.tex" | Out-Null

Write-Host "==> Pass 2: bibtex" -ForegroundColor Cyan
bibtex "$Paper"

Write-Host "==> Pass 3: pdflatex" -ForegroundColor Cyan
pdflatex -interaction=nonstopmode "$Paper.tex" | Out-Null

Write-Host "==> Pass 4: pdflatex (final)" -ForegroundColor Cyan
pdflatex -interaction=nonstopmode "$Paper.tex" | Out-Null

Write-Host "==> Selesai: $Paper.pdf" -ForegroundColor Green
