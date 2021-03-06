
# vegTemplates

A collection of automatic documents using the package
[`yamlme`](https://github.com/kamapu/yamlme/).

## Installation

To install the development version, use the package
[`remotes`](https://remotes.r-lib.org/):

``` r
library(remotes)
install_github("kamapu/vegTemplates")
```

## Get ready in advance

Before you use this package, you need to know the structure of objects
defined as classes [`taxlist`](https://docs.ropensci.org/taxlist/) and
[`vegtable`](https://github.com/kamapu/vegtable/). For the first case
you can take a look into the article written by [Alvarez & Luebert
(2018)](https://doi.org/10.3897/bdj.6.e23635).

Next to it, you may need experience working with
[`rmarkdown`](https://rmarkdown.rstudio.com/) and perhaps
[LaTeX](https://latex.org/) and [`knitr`](https://yihui.org/knitr/), as
well. They will be here implemented by the package
[`yamlme`](https://kamapu.github.io/rpkg/yamlme/).

## Examples

### Taxonomic checklist

Here an automatic checklist using the example data set released in the
package `taxlist` (called **Easplist**).

``` r
library(taxlist)
library(vegTemplates)

checklist(Easplist, output_file = "ea-checklist", exclude = "family",
    prefix = c(family = "# "), output = "html_document", alphabetic = TRUE)
```

With the option `'exclude = "family"'` you prevent family names to be
formatted in italics. With the option `'prefix = c(family = "# ")'` you
add a markdown command to set families as sections in the document. With
the option `'output = "html_document"'` we set the output as a HTML
document instead of the default PDF.

Check the output [here](ea-checklist.html).
