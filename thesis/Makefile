SHELL = /bin/bash
PDF = mgr.pdf
IMG_DIR = img/
SVG = $(wildcard img/*.svg)
PDF_IMG = $(subst .svg,.pdf,$(SVG))

all: $(PDF)

$(PDF_IMG): %.pdf: %.svg
	inkscape -A $@ $< 2&> /dev/null

#%.pdf: %.tex
#	pdflatex $< && pdflatex $<	


mgr.pdf: mgr.tex bib.bib $(PDF_IMG)
	pdflatex $< && bibtex mgr && pdflatex $< && pdflatex $<
clean:
	rm -f *.{aux,log,nav,out,snm,toc,pdf,bbl,blg,thm} $(PDF_IMG)
