REPORT = report
TEMPFILES = *.aux *.ps *.log *.bak *.bbl *.blg *.toc *.dvi
TEMPDIR = .tmp

all:
	latex $(REPORT)
	dvipdf $(REPORT).dvi
	#cp report.pdf ~/public_html/
	#evince report.dvi &
	rm -f $(TEMPFILES)

pdf:
	latex $(REPORT)
	#bibtex $(REPORT)
	#bibtex $(REPORT)
	#latex $(REPORT)
	#latex $(REPORT)
	dvipdf $(REPORT).dvi
	#git add report.pdf
	rm -f $(TEMPFILES) *.dvi

clean:
	rm -f *~ .*.swp *.*.orig *.*.backup
	rm -f $(TEMPFILES) *.dvi *.pdf
	rm -rf $(TEMPDIR)

