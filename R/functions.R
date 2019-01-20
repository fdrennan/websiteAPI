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

#' @export update_docker
update_docker <- function() {
  file_path <- paste0(getwd(), "/R/plumber.R")
  file_dest <- paste0(getwd(), "/misc/plumber.R")
  file.copy(file_path, file_dest, overwrite = TRUE)
}

#' @export get_samps
get_samps <- function(samps = 100) {

  con <- dbConnect(PostgreSQL(),
                   dbname   = 'linkedin',
                   host     = 'drenr.com',
                   port     = 5432,
                   user     = "linkedin_user",
                   password = "password")

  dbListTables(con)

  p_flights = tbl(con, in_schema("public", 'p_flights'))

  n_rows = 336776

  samps = sample(1:n_rows, samps)

  values <- p_flights %>%
    mutate(n = row_number()) %>%
    filter(n %in% samps) %>%
    collect

  dbDisconnect(con)

  return(toJSON(values, pretty = TRUE))

}

# docker build -t dockerfile .
# docker exec -it 80caef3f2980 sh
# docker run --rm -d -p 8000:8000 -v `pwd`/plumber.R:/plumber.R dockerfile /plumber.R

