REPORT = main.tex
TEMPFILES = *.aux *.ps *.log *.bak *.bbl *.blg *.toc *.dvi
TEMPDIR = .tmp

all:
	latex $(REPORT)
	latex $(REPORT)
	#evince report.dvi &
	rm -f $(TEMPFILES)

pdf:
	latex $(REPORT)
	latex $(REPORT)
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

