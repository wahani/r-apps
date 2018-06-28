#!/usr/bin/env Rscript
# Author: Sebastian Warnholz
# Email: Sebastian.Warnholz@inwt-statistics.de

suppressPackageStartupMessages({
  stopifnot(require(drat))
  stopifnot(require(stringr))
})

getArgument <- function(name, default) {
  val <- Sys.getenv(name)
  if (val == "") default else as(val, class(default))
}

opts <- list(
  depsPkg = getArgument("DEPS_PKG", character()),
  depsRepos = getArgument("DEPS_REPOS", "https://inwt-vmeh2.inwt.de/r-repo/")
)

downloadPackages <- function(depsStatic) {
  unlist(lapply(depsStatic, function(pkg) {
    repos <- opts$depsRepos
    repoSub <- "src/contrib/"
    pkgName <- readLines(paste0(repos, repoSub))
    pkgName <- stringr::str_extract(pkgName, sprintf(">%s_.*tar\\.gz", pkg))
    pkgName <- pkgName[Negate(is.na)(pkgName)]
    pkgName <- sub("^>", "", pkgName)
    download.file(
      paste0(repos, repoSub, pkgName),
      fname <- paste(tempdir(), pkgName, sep = "/")
    )
    fname
  }))
}

cat("Register dependencies ...")
depsPkg <- character()
if (dir.exists("./deps")) depsPkg <- c(
  cat("\n  source-packages in ./deps"),
  depsPkg,
  list.files("./deps", full.names = TRUE, pattern = "^.*\\.tar\\.gz$")
)

if (dir.exists("./deps/src/contrib")) depsPkg <- c(
  cat("\n  source-packages in ./deps/src/contrib"),
  depsPkg,
  list.files("./deps/src/contrib", full.names = TRUE, pattern = "^.*\\.tar\\.gz$")
)

if (length(opts$depsPkg) > 0) depsPkg <- c(
  cat("\n  fetching from ", opts$depsRepos),
  depsPkg,
  downloadPackages(unlist(strsplit(opts$depsPkg, split = " ")))
)

if (length(depsPkg) > 0) {
  for (pkg in sort(unique(depsPkg))) drat::insertPackage(pkg)
  cat("\n  done\n")
} else cat(" nothing found\n")

