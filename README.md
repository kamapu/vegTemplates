
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
[`rmarkdown`](https://rmarkdown.rstudio.com/) and perhaps <span
class="latex">L<sup>A</sup>T<sub>E</sub>X</span>. They will be here
implemented by the package
[`yamlme`](https://kamapu.github.io/rpkg/yamlme/).

## Examples

Here an automatic checklist using the example data set released in the
package `taxlist` (called **Easplist**). With `'exclude = "family"'` we
prevent family names to be formatted in italics. With the option
`'prefix = c(family = "# ")'` we will add a markdown command to set
families as sections in the document. With the option
`'output = "html_document"'` we set the output as a HTML document
instead of the default PDF.

``` r
library(taxlist)
library(vegTemplates)

check_list(Easplist, output_file = "ea-checklist", exclude = "family", prefix = c(family = "# "),
    output = "html_document")
```

Check the output [here](docs/ea-checklist.html).
