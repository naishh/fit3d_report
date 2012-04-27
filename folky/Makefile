REPORT = Thesis

all:
	latex $(REPORT)
	bibtex $(REPORT)
	bibtex $(REPORT)
	latex $(REPORT)	# Build dvi
	latex $(REPORT)	# Inserts reference indicators at points of citation
	dvipdf $(REPORT).dvi

diff:
	latex $(REPORT)-diff
	bibtex $(REPORT)-diff
	bibtex $(REPORT)-diff
	latex $(REPORT)-diff	# Build dvi
	latex $(REPORT)-diff	# Inserts reference indicators at points of citation
	dvipdf $(REPORT)-diff.dvi

clean:
	rm -f *.aux *.ps *.dvi *.log *~ *.bak *.bbl *.blg *.toc *.lot *.lof *.out

realclean: clean
	rm -f *.pdf

public: all
	install $(REPORT).pdf ~/www/
