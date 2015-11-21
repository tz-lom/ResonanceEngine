onPrepare <- function(inputs, code){

  if(is.function(globalenv()$onPrepare)) {
    globalenv()$onPrepare()
  }

  resetGlobals();


  callback <- eval(parse(text=paste("function(input){", code,  "}" )))

  .globals$code <- callback
  .globals$inputs <- lapply(inputs, SI)

  input <- function(index) {
    inputs[[index]]
  }

  .globals$code(input)

  if(is.function(globalenv()$onStart)) {
    globalenv()$onStart()
  }
}
