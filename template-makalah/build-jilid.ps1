# Build versi JILID (twoside, margin mirror)
$Paper = "template-makalah"
Write-Host "==> Build JILID (twoside mirror)" -ForegroundColor Cyan
pdflatex -interaction=nonstopmode "$Paper.tex" | Out-Null
pdflatex -interaction=nonstopmode "$Paper.tex" | Out-Null
Move-Item "$Paper.pdf" "MAKALAH_JILID.pdf" -Force
Write-Host "==> Selesai: MAKALAH_JILID.pdf" -ForegroundColor Green
