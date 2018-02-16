.SUFFIXES: .dot .pdf

DIAGRAMS=dot-filter.pdf foreach-filter.pdf empty-filter.pdf piped-filter.pdf identity-filter.pdf field-filter.pdf field-filter-not-found.pdf field-filter-error.pdf field-filter-no-error.pdf array-filter.pdf array-filter-not-found.pdf array-filter-range.pdf array-filter-multi.pdf comma-filter.pdf pipe-filter.pdf foreach-filter-error.pdf foreach-filter-no-error.pdf foreach-filter-empty.pdf

all: jq.pdf

clean:
	rm -f *.pdf *.aux *.log *.nav *.out *.snm *.toc *.vrb

jq.pdf: jq.tex ${DIAGRAMS}
	pdflatex jq.tex
	pdflatex jq.tex

.dot.pdf:
	dot -Tpdf -o $@ $<

.PHONY: all clean
