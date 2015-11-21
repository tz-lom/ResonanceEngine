onDataBlock <- function(id, data) {


  index <- function(index) {
    if(index == id) {
      data
    } else {
      NULL
    }
  }

  .globals$code(index)
}

onDataBlock.message <- function(id, msg, timestamp){
  attr(msg, 'TS') <- timestamp
  onDataBlock(id, msg)
}

onDataBlock.double <- function(id, vector, samples, timestamp){
  print(length(vector))
  print(samples)

  data <- matrix(vector, nrow=samples, byrow = T)
  attr(data, 'TS') <- seq(to=timestamp, by=1E6/.globals$inputs[[id]]$samplingRate, length.out=samples)
  onDataBlock(id, data)
}
