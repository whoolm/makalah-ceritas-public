#!/bin/bash
set -e
pdflatex -interaction=nonstopmode template-makalah.tex > /dev/null
pdflatex -interaction=nonstopmode template-makalah.tex > /dev/null
echo "==> Selesai: template-makalah.pdf"
