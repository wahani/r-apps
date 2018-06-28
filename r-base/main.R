#!/usr/bin/env Rscript
# Author: Sebastian Warnholz
# Email: Sebastian.Warnholz@inwt-statistics.de

source("/includes/validate-settings.R", local = new.env())
source("/includes/register-dependencies.R", local = new.env())

if (file.exists("DESCRIPTION")) {
  cat("Looks like a package...\n"); Sys.sleep(1)
  suppressPackageStartupMessages(stopifnot(require(devtools)))
  devtools::install(dependencies = TRUE)
  library(devtools::as.package(".")$package, character.only = TRUE)
  main()
} else if (file.exists("main.R")) {
  cat("Found source file:\n\n")
  source("main.R")
} else {
  cat("Entering help ...\n\n");Sys.sleep(1)
  system("less /includes/README.plain")
}

