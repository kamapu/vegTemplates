# TODO:   Importing data from database
# 
# Author: Miguel Alvarez
################################################################################

# Installing packages from GitHub
library(devtools)
install_github("ropensci/taxlist", "dev")
install_github("kamapu/vegtable", "dev")
install_github("kamapu/vegtableDB", "dev")
install_github("kamapu/biblio")
install_github("kamapu/biblioDB")

# Loading library
library(RPostgreSQL)
library(vegtableDB)

# Restore PostgreSQL database and connect
DB <- "vegetation_v3"

do_restore(
    dbname = DB,
    user = "miguel",
    filepath = file.path("../../db-dumps/00_dumps", DB)
)

conn <- connect_db(DB, user = "miguel")

# Check specimens
ea_splist <- db2taxlist(conn, taxonomy = "ea_splist")
ea_splist

# Cyperaceae subset
cype <- subset(ea_splist, TaxonName == "Cyperaceae", slot = "taxonNames",
    keep_parents = TRUE, keep_children = TRUE)

indented_list(cype)



