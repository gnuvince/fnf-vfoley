all: ppbert-rust.pdf

ppbert-rust.pdf: ppbert-rust.tex good.eps bad.eps ugly.eps
	pdflatex ppbert-rust.tex
	pdflatex ppbert-rust.tex

clean:
	rm -rf *.pdf *.log *.aux *.snm *.nav *.toc *.vrb *.out

.PHONY: all clean
