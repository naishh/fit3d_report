REPORT = main
#TEMPFILES = *.aux *.ps *.log *.bak *.bbl *.blg *.toc *.dvi
TEMPFILES = *.aux *.ps *.log *.bak *.bbl *.blg *.toc 
TEMPDIR = .tmp

all:
	latex $(REPORT).tex
	bibtex $(REPORT)
	latex $(REPORT).tex
	latex $(REPORT).tex
	#evince report.dvi &
	rm -f $(TEMPFILES)

pdf:
	latex $(REPORT).tex
	bibtex $(REPORT)
	latex $(REPORT).tex
	latex $(REPORT).tex
	dvipdf $(REPORT).dvi
	git add $(REPORT).pdf
	rm -f $(TEMPFILES) *.dvi

pdfshow:
	latex $(REPORT).tex
	bibtex $(REPORT)
	latex $(REPORT).tex
	latex $(REPORT).tex
	dvipdf $(REPORT).dvi
	git add $(REPORT).pdf
	rm -f $(TEMPFILES) *.dvi
	evince main.pdf

clean:
	rm -f *~ .*.swp *.*.orig *.*.backup
	rm -f $(TEMPFILES) *.dvi *.pdf
	rm -rf $(TEMPDIR)

