PAPER=template-makalah

all: $(PAPER).pdf

$(PAPER).pdf: $(PAPER).tex kp.tex bab1.tex bab2.tex bab3.tex pustaka.tex cover.png
	pdflatex -interaction=nonstopmode $(PAPER).tex > /dev/null
	pdflatex -interaction=nonstopmode $(PAPER).tex > /dev/null

clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.bbl *.blg *.synctex.gz

.PHONY: all clean
