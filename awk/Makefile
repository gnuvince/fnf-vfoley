all: awk.pdf

awk.pdf: awk.tex
	pdflatex $<
	pdflatex $<

clean:
	rm -rf *.pdf *.log *.aux *.snm *.nav *.toc *.vrb *.out

.PHONY: all clean
