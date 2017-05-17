all: flow.pdf presentation.pdf
	make -C rotate

flow.pdf: flow.dot
	dot -Tpdf flow.dot -o flow.pdf

presentation.pdf: presentation.tex
	pdflatex presentation.tex
	pdflatex presentation.tex

clean:
	make -C rotate clean
	rm -f *.aux *.log *.out *.pdf *.nav *.snm *.toc

.PHONY: clean all
