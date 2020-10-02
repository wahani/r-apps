
devtools::document()
res <- devtools::check(".", error_on = "warning")
str(res)
