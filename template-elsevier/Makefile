PAPER = template_elsevier
BIB   = referensi_template

all: $(PAPER).pdf

$(PAPER).pdf: $(PAPER).tex $(BIB).bib
	pdflatex -interaction=nonstopmode $(PAPER).tex
	bibtex $(PAPER)
	pdflatex -interaction=nonstopmode $(PAPER).tex
	pdflatex -interaction=nonstopmode $(PAPER).tex

clean:
	rm -f *.aux *.log *.bbl *.blg *.out *.toc *.synctex.gz *.fls *.fdb_latexmk *.lof *.lot

cleanall: clean
	rm -f $(PAPER).pdf

.PHONY: all clean cleanall
