.globals <- new.env()

resetGlobals <- function(){
  .globals$queue <- list()
  .globals$code <- function(a){}
  .globals$inputs <- list()
  .globals$outputId <- 1
}

addToQueue = function(cmd, ...){
  .globals$queue <- append(
    .globals$queue,
    list(
      list(
        cmd=cmd,
        args = list(...)
      )
    )
  )
}

popQueue <- function(){
  ret <- .globals$queue
  .globals$queue <- list()
  ret
}
