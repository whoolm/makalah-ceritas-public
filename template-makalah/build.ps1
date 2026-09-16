$Paper = "template-makalah"
Write-Host "==> Pass 1: pdflatex" -ForegroundColor Cyan
pdflatex -interaction=nonstopmode "$Paper.tex" | Out-Null
Write-Host "==> Pass 2: pdflatex" -ForegroundColor Cyan
pdflatex -interaction=nonstopmode "$Paper.tex" | Out-Null
Write-Host "==> Selesai: $Paper.pdf" -ForegroundColor Green
