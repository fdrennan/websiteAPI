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
  # 18.220.132.82/create_quest?chapter=1&question_number=1&question_text="Hello"&s3_audio_loc="jalsd"
  library(websiteApi)

  # dummy comment for testing auto-deploy, test 2

  # Build the response object (list will be serialized as JSON)
  response <- list(statusCode = 200,
                   data = "",
                   message = "sucess",
                   console = list(
                     args = list(
                       samps = samps
                     ),
                     runtime = 0
                   )
  )

  response <- tryCatch(
    {
      # Run the algorithm
      tic()
      response$data <- get_samps(
        samps = samps
      )
      timer <- toc(quiet = T)
      response$console$runtime <- as.numeric(timer$toc - timer$tic)

      return(response)
    },
    error = function(err) {
      response$statusCode <- 400
      response$message <- paste(err)
      return(response)
    }
  )
  return(response)
}


