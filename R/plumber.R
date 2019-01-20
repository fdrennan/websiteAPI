#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)

#* @apiTitle Plumber Example API

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = "") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @png
#* @get /plot
function() {
  rand <- rnorm(100)
  hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
  as.numeric(a) + as.numeric(b)
}

#' @get /hello
#' @html
function(){
  "<html><h1>hello world</h1></html>"
}

#* @serializer unboxedJSON
#* @get /meggan
f = function(n=100, string = 'I love Meggan!'){
  a = rep(string, n)
  jsonlite::toJSON(a)
}

#* @serializer unboxedJSON
#* @param samps How many rows
#* @get /flights
function(samps = 100) {
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


  toJSON(values, pretty = TRUE)
}


