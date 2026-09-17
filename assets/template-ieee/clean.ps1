# Bersihkan file temporary LaTeX
Remove-Item -Force -ErrorAction SilentlyContinue *.aux, *.log, *.bbl, *.blg, *.out, *.toc, *.synctex.gz, *.fls, *.fdb_latexmk, *.lof, *.lot
Write-Host "==> File temporary dibersihkan" -ForegroundColor Green
