library(knitr)

setwd("source/")

lf <- list.files(".", pattern = ".Rrst")

for (f in lf) {
    knit(f)
    purl(f)
}


lf <- list.files(".", pattern = "\\.rst$")

for (f in lf) {
    input <- readLines(f)
    input <- c(".. raw:: html",
               "    :file: zelignav.html\n",
               input)
    writeLines(input, f)
}

setwd("..")
