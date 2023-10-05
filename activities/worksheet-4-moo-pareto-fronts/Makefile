HTML_FILES=moo-pareto-fronts-worksheet.html moo-pareto-fronts-worksheet-solutions.html
PDF_FILES=moo-pareto-fronts-worksheet.pdf moo-pareto-fronts-worksheet-solutions.pdf
WORKSHEET_FILES=moo-pareto-fronts-worksheet.html moo-pareto-fronts-worksheet.pdf
SOLUTION_FILES=moo-pareto-fronts-worksheet-solutions.html moo-pareto-fronts-worksheet-solutions.pdf

all : $(HTML_FILES) $(PDF_FILES)
	echo "All files are now up to date"

html: $(HTML_FILES)
	echo "All html files are now up to date"

pdf: $(PDF_FILES)
	echo "All pdf files are now up to date"

worksheet: $(WORKSHEET_FILES)
	echo "All worksheet files are now up to date"

solution: $(SOLUTION_FILES)
	echo "All worksheet files are now up to date"

clean : 
	rm -f $(HTML_FILES)
	rm -f $(PDF_FILES)
	echo "Directory cleaned" 

%.html : %.Rmd
	Rscript -e 'rmarkdown::render("$<", output_format = "html_document")'

%.pdf : %.Rmd
	Rscript -e 'rmarkdown::render("$<", output_format = "pdf_document")'


