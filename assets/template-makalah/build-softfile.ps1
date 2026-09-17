# Build versi SOFT FILE (oneside, margin simetris)
$Paper = "template-makalah-softfile"
Write-Host "==> Build SOFT FILE (oneside simetris)" -ForegroundColor Cyan
pdflatex -interaction=nonstopmode "$Paper.tex" | Out-Null
pdflatex -interaction=nonstopmode "$Paper.tex" | Out-Null
Move-Item "$Paper.pdf" "MAKALAH_SOFTFILE.pdf" -Force
Write-Host "==> Selesai: MAKALAH_SOFTFILE.pdf" -ForegroundColor Green
