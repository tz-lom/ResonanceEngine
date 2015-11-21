test_that("simple pipeline", {

  A <- matrix(nrow=0, ncol=2)
  SI(A) <- list(
    type='channels',
    channels= 2,
    samplingRate= 20,
    online = T
  )

  onPrepare(
    list(
      A
    )
    ,
    "
    src <- input(1)
    spat <- pipe.spatial(src, matrix(c(0,1,1,0), ncol=2))
    createOutput(spat, 'out')
    "
  )
  onDataBlock.double(1, 1:10, 2, 12)
  #onDataBlock(1, matrix(1:10, ncol=2))


})
