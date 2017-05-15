all: awk.pdf

ppbert-rust.pdf: awk.tex
	pdflatex $<
	pdflatex $<

clean:
	rm -rf *.pdf *.log *.aux *.snm *.nav *.toc *.vrb *.out

.PHONY: all clean
