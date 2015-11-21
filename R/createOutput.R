createOutput <- function(data, name){

  processor(
    data,
    prepare = function(env){

      id <- .globals$outputId
      .globals$outputId <- .globals$outputId+1

      if(SI(data)$type == 'channels')
      {
        addToQueue(
          "createOutputStream",
          id = id,
          name = name,
          typeName = 'double',
          samplingRate = SI(data)$samplingRate,
          channels = SI(data)$channels
        )
      }

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
