# TODO:   Test for function check_list()
# 
# Author: Miguel Alvarez
################################################################################

library(taxlist)
library(vegTemplates)

Piperaceae <- subset(Easplist, TaxonName == "Piperaceae",
    slot = "taxonNames", keep_children = TRUE, keep_parents = TRUE)

check_list(Piperaceae, output_file = "lab/piperaceae", exclude = "family")

check_list(Piperaceae, output_file = "lab/piperaceae2", exclude = "family",
    prefix = c(family = "# "))

check_list(Easplist, output_file = "lab/ea-splist", exclude = "family",
    prefix = c(family = "# \\sc{"), suffix = c(family = "}"))
