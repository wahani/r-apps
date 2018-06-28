#!/usr/bin/env Rscript
# Author: Sebastian Warnholz
# Email: Sebastian.Warnholz@inwt-statistics.de

source("/includes/validate-settings.R")
source("/includes/register-dependencies.R")

suppressPackageStartupMessages(stopifnot(require(devtools)))

if (!file.exists("DESCRIPTION")) {
  cat("Can't do check: not a package\n")
} else {
  cat("Looks like a package...\n"); Sys.sleep(1)
  devtools::install(dependencies = TRUE)
  devtools::check()
}
