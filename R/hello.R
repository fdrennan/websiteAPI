# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

hello <- function() {
  print("Hello, world!")
}

update_docker <- function() {
  file_path <- paste0(getwd(), "/R/plumber.R")
  file_dest <- paste0(getwd(), "/misc/plumber.R")
  file.copy(file_path, file_dest, overwrite = TRUE)
}

# docker build -t dockerfile .
