test_that("offline process trivial", {

  A <- source.channels(matrix(1:20, ncol=2), samplingRate = 10)

  offlineProcess(
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



})
