#!/usr/bin/env Rscript
# author: Sebastian Warnholz
# email: sebastian.warnholz@inwt-statistics.de

suppressMessages({
  library(docopt)
  library(devtools)
})

## configuration for docopt
doc <- "Usage: install.R [-h] [-x] [PKGS...]
-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)

if (opt$usage) {
  cat(doc, "\n\n")
  cat("where PKGS... is one or more packages.
Examples:
  install.R modules\n")
  q("no")
}

# source("/includes/validate-settings.R")
# source("/includes/register-dependencies.R")

if (file.exists("DESCRIPTION")) {
  invisible(devtools::install())
} else if ((pkg <- Sys.getenv("PKG")) != "") {
  invisible(install.packages(pkg))
} else {
  invisible(install.packages(opt$PKGS))
}
