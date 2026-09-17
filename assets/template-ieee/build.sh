#!/usr/bin/env bash
set -e

PAPER="template_ieee"
BIB="referensi_template"

echo "==> Pass 1: pdflatex"
pdflatex -interaction=nonstopmode "$PAPER.tex" > /dev/null

echo "==> Pass 2: bibtex"
bibtex "$PAPER"

echo "==> Pass 3: pdflatex"
pdflatex -interaction=nonstopmode "$PAPER.tex" > /dev/null

echo "==> Pass 4: pdflatex (final)"
pdflatex -interaction=nonstopmode "$PAPER.tex" > /dev/null

echo "==> Selesai: $PAPER.pdf"
