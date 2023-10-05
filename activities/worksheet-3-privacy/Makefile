HTML_FILES=privacy_worksheet.html privacy_worksheet-solutions.html
PDF_FILES=privacy_worksheet.pdf privacy_worksheet-solutions.pdf
WORKSHEET_FILES=privacy_worksheet.html privacy_worksheet.pdf
SOLUTION_FILES=privacy_worksheet-solutions.html privacy_worksheet-solutions.pdf

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

%.html : %.md
	Rscript -e 'rmarkdown::render("$<", output_format = "html_document")'

%.pdf : %.md
	Rscript -e 'rmarkdown::render("$<", output_format = "pdf_document")'
