# Build dua-duanya sekaligus (jilid + soft file)
Write-Host "=== BUILD SEMUA VERSI ===" -ForegroundColor Yellow
& .\build-jilid.ps1
& .\build-softfile.ps1
Write-Host ""
Write-Host "Hasil:" -ForegroundColor Green
Get-Item MAKALAH_JILID.pdf, MAKALAH_SOFTFILE.pdf | Select Name, @{N='KB';E={[math]::Round($_.Length/1KB,1)}}
