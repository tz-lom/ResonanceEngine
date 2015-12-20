createOutput <- function(data, name){

  processor(
    data,
    prepare = function(env){

      id <- .globals$outputId
      .globals$outputId <- .globals$outputId+1

      args <- SI(data)
      args$id <- id

      addToQueue(
        "createOutputStream",
        args
      )

      env$id <- id
    },
    online = function(data){
      if(length(data)>0){
        addToQueue(
          "sendBlockToStream",
          id = id,
          data= data
        )
      }

      list()
    }
  )

}
