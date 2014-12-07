library(knitr)

setwd("source/")

lf <- list.files(".", pattern = "installation_quickstart.Rrst")

for (f in lf) {
  knit(f)
  purl(f)
}

## lfmd <- list.files(".", pattern = ".Rmd")

## for (f in lfmd) {
##   knitr::knit2html(f)
## }

setwd("..")
