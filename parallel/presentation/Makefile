all: parallel.pdf

parallel.pdf: parallel.tex
	pdflatex $<
	pdflatex $<

clean:
	rm -rf *.pdf *.log *.aux *.snm *.nav *.toc *.vrb *.out

.PHONY: all clean
