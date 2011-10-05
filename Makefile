REPORT = main
#TEMPFILES = *.aux *.ps *.log *.bak *.bbl *.blg *.toc *.dvi
TEMPFILES = *.aux *.ps *.log *.bak *.bbl *.blg *.toc 
TEMPDIR = .tmp

all:
	latex $(REPORT).tex
	latex $(REPORT).tex
	#evince report.dvi &
	rm -f $(TEMPFILES)

pdf:
	latex $(REPORT).tex
	latex $(REPORT).tex
	#bibtex $(REPORT)
	#bibtex $(REPORT)
	#latex $(REPORT)
	#latex $(REPORT)
	dvipdf $(REPORT).dvi
	git add $(REPORT).pdf
	rm -f $(TEMPFILES) *.dvi

clean:
	rm -f *~ .*.swp *.*.orig *.*.backup
	rm -f $(TEMPFILES) *.dvi *.pdf
	rm -rf $(TEMPDIR)

