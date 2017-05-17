all: rotate.pdf rotate.rs rotate

rotate.pdf:	rotate.nw
	noweave -index -delay $< > rotate.tex
	pdflatex rotate.tex
	pdflatex rotate.tex

rotate.rs: rotate.nw
	notangle -R$@ $< > $@

rotate: rotate.rs
	rustc $<

clean:
	rm -f *.aux *.tex *.log *.out *.pdf
	rm -f rotate.rs rotate

.PHONY: clean all
