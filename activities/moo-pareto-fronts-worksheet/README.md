# Multiobjective Optimisation and Pareto Fronts Worksheet 

Excercises and solutions covering: 

- 
- 
- 
- 

## Getting started 

After [installing Quarto](https://quarto.org/docs/get-started/) and cloning a local version of the repository, the worksheet can be rendered at the command line using two commands.  

```
quarto render --profile questions
quarto render --profile solutions
```

A shell script is provided to render all format/document combinations via a single command. 

```
bash render.sh
```

If you only need to render specific format/document combinations, you may further specify the `to` argument. 

```
quarto render --profile questions --to pdf
quarto render --profile solutions --to html
```

## File Structure

- `moo-pareto-fronts-worksheet.qmd` contains the content for all documents, with conditional inclusion statements.
- `_quarto.yml` contains meta-data relevant to all documents.
- `_quarto-*.yml` contains document-specific metadata.
- `render.sh` contains provides a wrapper to render all document/format combinations from the command line.
