newDataBlock.message <- function(message, timestamp){
  attr(message, 'TS') <- timestamp
  ret <- list(msg)
  class(ret) <<- c('DataBlock','message')
  ret
}
