offlineProcess <- function(inputs, code, simulateOnline=F){

  onPrepare(inputs, code)
  q <- popQueue()

  for(i in q){
    switch(i$cmd,
      createOutputStream={

        switch(i$args$typeName,
               double={

               },
               message={

               }
               )

      },
      sendBlockToStream={

      }
    )
  }

}
