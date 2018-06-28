#!/usr/bin/env Rscript
# Author: Sebastian Warnholz
# Email: Sebastian.Warnholz@inwt-statistics.de

local({
  cat("Validate Settings ...")
  if (file.exists("./.Rprofile")) {
    cat("\n")
    cat("Detected local .Rprofile. This is potentially messing up the local config:\n")
    cat("MRAN:", reposRemote <- getOption("repos")["CRAN"], "\n")
    cat("LOCAL:", reposLocal <- getOption("repos")["LOCAL"], "\n")
    if (!grepl("mran", reposRemote)) stop("The remote repository has to be versioned!")
    if (!grepl("r-repo", reposLocal)) warning("Local repos is not set correctly.")
  } else {
    Sys.sleep(1)
    cat(" OK\n")
  }
})
