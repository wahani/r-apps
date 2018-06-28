#!/usr/bin/env Rscript
# author: Sebastian Warnholz
# email: sebastian.warnholz@inwt-statistics.de
# started from littler/installGithub.R - however experienced problems while
# using 'remotes' instead of 'devtools'.

suppressMessages({
  library(docopt)
  library(devtools)
})

## configuration for docopt
doc <- "Usage: installGithub.R [-h] [-x] [REPOS...]
-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where REPOS... is one or more GitHub repositories.
Examples:
  installGithub.R INWT/dbtools\n")
    q("no")
}

pkgs <- lapply(strsplit(opt$REPOS, "-"), function(pkg) {
  if (length(pkg) == 1) c(pkg, "master")
  else if (length(pkg) == 2) pkg
  else stop("wrong version identifier. '-' is used for split.")
})

invisible(lapply(pkgs, function(pkg)
  install_github(pkg[1], ref = pkg[2])))
