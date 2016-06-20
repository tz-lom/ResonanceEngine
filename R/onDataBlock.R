onDataBlock <- function(id, data) {

  X <- .globals$inputsData[[id]]
  .globals$inputsData[[id]] <- data

  .globals$env$process()

  .globals$inputsData[[id]] <- X
}

onDataBlock.message <- function(id, msg, timestamp){
  attr(msg, 'TS') <- timestamp
  onDataBlock(id, list(msg))
}

onDataBlock.double <- function(id, vector, samples, timestamp){
  data <- matrix(vector, nrow=samples, byrow = T)
  attr(data, 'TS') <- seq(to=timestamp, by=1E6/.globals$inputs[[id]]$samplingRate, length.out=samples)
  SI(data) <- .globals$inputs[[id]]
  onDataBlock(id, data)
}
