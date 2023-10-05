HTML_FILES=fairness_worksheet.html fairness_worksheet-solutions.html
PDF_FILES=fairness_worksheet.pdf fairness_worksheet-solutions.pdf
WORKSHEET_FILES=fairness_worksheet.html fairness_worksheet.pdf
SOLUTION_FILES=fairness_worksheet-solutions.html fairness_worksheet-solutions.pdf
IMAGE_FILES= images/confusion_matrices_q7_plot.png confusion_matrices_q6_plot.png confusion_matrices_q5_plot.png confusion_matrices_Q4_pt3_solution.png confusion_matrices_q4_pt3_plot.png

all : $(HTML_FILES) $(PDF_FILES)
	echo "All files are now up to date"

html: $(HTML_FILES)
	echo "All html files are now up to date"

pdf: $(PDF_FILES)
	Rscript make_fairness_exercise_images.R
	echo "All pdf files are now up to date"

worksheet: $(WORKSHEET_FILES)
	echo "All worksheet files are now up to date"

solution: $(SOLUTION_FILES)
	echo "All worksheet files are now up to date"

images : $(IMAGE_FILES)
	echo "All image files are now up to date"

clean : 
	rm -f $(HTML_FILES)
	rm -f $(PDF_FILES)
	rm -f images/*.png
	echo "Directory cleaned" 

%.html : %.md
	Rscript -e 'rmarkdown::render("$<", output_format = "html_document")'

%.pdf : %.md
	Rscript -e 'rmarkdown::render("$<", output_format = "pdf_document")'


images/%.png: make_fairness_exercise_images.R 
	Rscript make_fairness_exercise_images.R

