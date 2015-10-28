library(knitr)

setwd("source/")

lf <- list.files(".", pattern = ".Rrst")

for (file_Rrst in lf) {
    knit(file_Rrst)
    purl(file_Rrst)
}


lf <- list.files(".", pattern = "\\.rst$")

for (file_rst in lf) {
    input <- readLines(f)
    input <- c(".. raw:: html",
               "    :file: zelignav.html\n",
               input)
    writeLines(input, f)
}

setwd("..")
