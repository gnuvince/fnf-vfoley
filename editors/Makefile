all: editors.pdf

clean:
	latexmk -CA
	rm -f *.nav *.snm

editors.pdf: editors.tex
	latexmk -pdf

.PHONY: all clean
