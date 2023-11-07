
1. Create a new quarto project.

```{{bash}}
quarto create project default <NAME>
```

 This will create a directory called <NAME> and create a quarto project within that directory. 

```
Creating project at PATH/TO/CURRENT/DIRECTORY/<NAME>:
  - Created _quarto.yml
  - Created .gitignore
  - Created <NAME>.qmd
```

You will also get the option of whether to open the project in VSCode or RStudio if you have these editors installed. IF you open it with RStudio this additionally creates two R project files: a shortcut to open the project in RStudio and a hidden folder: 

- A project file, `<NAME>.Rproj`, which contains various project options and acts as a shortcut for opening the project in RStudio directly from the filesystem;

- A hidden directory, `.Rproj.user`, where project-specific temporary files (e.g. auto-saved source documents, window-state, etc.) are stored. This directory is should be added to .Rbuildignore, .gitignore, etc. if required.

We can keep these files out of version control by adding them to the newly created `.gitignore`, staging and commiting these changes. 

```{{markdown, title=".gitignore"}}
/.quarto/

# Project files
.Rproj.user
checkpoint-1.Rproj
```

```{{bash}}
git add .gitignore
git commit -m "Ignore project metadata files"
```

We can the render the tempalate document. 

```{{bash}}
quarto render <NAME>.qmd
```

which will make the corresponding HTML file `checkpoint-1.html` and a directory of auxillhiary files `checkpoint-1_files/` for that HTML page. 


## Shared metadata 

One of the most important features of Quarto Projects is the ability to share YAML metadata options across multiple documents. Shared metadata can be defined at both the project and directory level. All Quarto projects include a _quarto.yml configuration file. Any document rendered within the project directory will automatically inherit the metadata defined at the project level. Here is an example of what the _quarto.yml file might look like: 


The default `_quarto.yaml` is bland. I want to create both PDF and HTML versions output for these exercises, so will jazz it up a bit. This is exactly what would go in the YAML header if we were creating this as a stand-alone quarto document. Note that some of these YAML options are common to both formats while others are output specific.

Mild:
```
project:
  title: "Checkpoint-1"
```

Wild: 
```
title: "Checkpoint 1 Exercises"
subtitle: "Solutions"
author: "Zak Varty"

format: 
  html:
    toc: true
    self-contained: true
  pdf: default
format-links: true        # Add link in HTML doc to view PDF
``` 

We can render the document again to see that these changes have taken effect. This should give us an updated HTML file with our new metadata added, and a PDF version of the same document. By setting creating a self-contained HTML document we no longer have an auxihiliary folder of files, instead this information is stored within the HTML file itself - making it larger but portable. 


## Add questions and solutions

Questions are added as plain text. To make the solutions visually distinct, I add wrap them in a tip callout block.

```
1. Question text 

::: {.callout-tip title="Solution"}
Solution text goes here.
:::

2. Question text 

::: {.callout-tip title="Solution"}
Solution text goes here.
:::
```

## Hiding content in Quarto documents

To allow the conditional inclusion of the solutions, we can wrap them in a div (:::) with the `.content-visible` class. Note, this has to have more colons than the divs it contains. 

```
1. Question text 

:::: {.content-visible}
::: {.callout-tip title="Solution"}
Solution text goes here.
:::
::::

2. Question text 

:::: {.content-visible}
::: {.callout-tip title="Solution"}
Solution text goes here.
:::
::::
```

Re-rendering this shouldn't change a thing, but we can manually switch out a `.content-visible` for a `content-hidden` to suppress each solution in the rendered output. We can even use find-and-replace to do this for all questions at once.

```
1. Question text 

:::: {.content-visible}
::: {.callout-tip title="Solution"}
Solution text goes here. This is visible in the rendered documents.
:::
::::

2. Question text 

:::: {.content-hidden}
::: {.callout-tip title="Solution"}
Solution text goes here. This is hidden in the rendered documents.
:::
::::
```

This is progress, we now have a way of compiling both the question and solutions from a single source file. However, it's the typesettig equivalent of commenting out lines in your code to change the output of a script. How can we do this programatically? 

## Conditional hiding based on output format 

If we want different text to be shown in different formats then this can be done easily using the `when-format` or `unless-format` conditions. Both of the below examples will produce the same outputs.


```
1. Question text 

:::: {.content-visible when-format="html"}
::: {.callout-tip title="Solution"}
Solution text goes here. This is visible in the rendered HTML documents.
:::
::::

2. Question text 

:::: {.content-visible when-format="pdf"}
::: {.callout-tip title="Solution"}
Solution text goes here. This is hidden in the rendered PDF documents.
:::
::::
```

```
1. Question text 

:::: {.content-hidden unless-format="html"}
::: {.callout-tip title="Solution"}
Solution text goes here. This is visible in the rendered HTML documents.
:::
::::

2. Question text 

:::: {.content-hidden unless-format="pdf"}
::: {.callout-tip title="Solution"}
Solution text goes here. This is hidden in the rendered PDF documents.
:::
::::
```

Having both visible/hidden and the when/unless options might seem redundant here. That's because we only have two output types. If we we were also rendering this document to a jupyter notebook and revealJS slides, then having both the visible/hidden and the when/unless options would allows us to write these conditional inclusions in the clearest way possible.

This would be a great solution if we needed a PDF handout and then were going to publish the solutions online. But that's not what we were after, we want HTML and PDF versions of _both_ the questions _and_ solutions. To do that we need to get a bit more sophisticated. 

::: {.callout-note}
The conditional inclusion of divs allows us to hide arbitrary, contiguous sections of a quarto document. It covers us whether we need our solutions tot contain only text, LaTeX math, tables or figures. 
We can do a similar trick using a a span (`[]{}`) to apply conditional inclusion to inline text too.

```
Some text
[in HTML.]{.content-visible when-format="html"}
[in PDF.]{.content-visible when-format="pdf"}
```
:::

## Quarto profiles 

Project profiles enable you to adapt the options, environment, and content of your projects for different scenarios. 

One use for these is to help with continuous integration, by creating development and production profiles. Conditional inclusion can then be managed based on which profile is active during compiliation.

::: {.content-visible when-profile="development"}
These are some development notes for future developers that should not be shown in the production version.
:::

We will use a this technique to create two profiles: `questions` and `solutions`. These profiles are just extra YAML files named `_quarto-questions.yml` and `_quarto-solutions.yml`, which get [merged](https://quarto.org/docs/projects/quarto-projects.html#metadata-merging) into the overall `_quarto.yml` before the document is rendered. 

In these profile specific YAML documents we will set a custom subtitle, so that we can tell the documents appart at a glance, so we remove this from `_quarto.yml`.


```{yml, title="_quarto.yml"}
title: "Checkpoint 1 Exercises"
author: "Zak Varty"

format: 
  html:
    toc: true
    self-contained: true
  pdf: default
format-links: true        # Add link in HTML doc to view PDF
```

Then create two profile-specific YAML documents with their own subtitles. We also need to set a profile-specific filename for the the rendered documents, so that we don't overwrite the PDF and HTML question sheets when we render the solutions.  

```{yml, title="_quarto-questions.yml"}
subtitle: "Question Sheet"
output-file: question-sheet
```

```{yml, title="quarto-solutions.yml"}
subtitle: "Solution Sheet"
output-file: solution-sheet
```

We can then add the conditional inclusion to our example document


```
1. Question text 

:::: {.content-visible when-profile="solutions"}
::: {.callout-tip title="Solution"}
Solution text goes here.
:::
::::

2. Question text 

:::: {.content-visible when-profile="solutions"}
::: {.callout-tip title="Solution"}
Solution text goes here.
:::
::::
```


We can then render the question and solution sheets individually from the command line.

```{{bash}}
quarto render --profile questions
quarto render --profile solutions
```

If we want to be more specific and only render the document/format combination we can do by specifying the `to` argument. 

```{{bash}}
quarto render --profile questions --to html
quarto render --profile questions --to pdf
quarto render --profile solutions --to html
quarto render --profile solutions --to pdf
```

If we now run `quarto render`, neither profile will be applied and we will get something like the question sheet (but without a subtitle) generated to `checkpoint-1.pdf` and `checkpoint-1.html`.

To avoid this, we can add one or more default profile to `_quarto.yml`.  My preferred behaviour is that `quarto render` without a profile argument should render both the question and solution sheets.

```{_quarto.yml}
title: "Checkpoint 1 Exercises"
author: "Zak Varty"
profile:
  default: questions,solutions
format:
  html:
    toc: true
    self-contained: true
  pdf: default
format-links: true        # Add link in HTML doc to view PDF
```

## Adding a Mark Scheme 

The final stage is to add a third profile for markers, which not only contain the worked solutions but how marks should be allocated. First we create a profile-specific YAML file. 

```{{title="_quarto-mark-scheme.yml"}}
subtitle: "Mark Scheme"
output-file: mark-scheme
```

We can add this to the list of default profiles:

```{{title="_quarto.yml"}}
profile:
  default: questions,solutions,mark-scheme
```

And finally add our marking criteria to each question using conditional inclusion. 

```
1. Question text 

:::: {.content-visible unless-profile="questions"}
::: {.callout-tip title="Solution"}
Solution text goes here.
:::
::::

:::: {.content-visible when-profile="mark-scheme"}
::: {.callout-idea title="Mark Scheme"}

- A stand alone mark scheme [1]
- Shown in an idea call-out  [1]

Award full marks for any valid alternative solution method. 
:::
::::


2. Question text 

:::: {.content-visible unless-profile="questions"}
::: {.callout-tip title="Solution"}
Solution text goes here.
::: {.content-visible when-profile="markscheme"}
**Mark Scheme:**
- A stand alone mark scheme [1]
- Shown in an idea callout  [1]

Award full marks for any valid alternative solution method.
:::
:::
::::
```



