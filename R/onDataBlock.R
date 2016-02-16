onDataBlock <- function(id, data) {

  .globals$env$input <- function(index) {
    if(index == id) {
      data
    } else {
      .globals$emptyInputs[[index]]
    }
  }

  if(is.function(.globals$env$process)) {
    .globals$env$process()
  }
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
