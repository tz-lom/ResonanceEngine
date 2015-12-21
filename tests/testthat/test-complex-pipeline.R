test_that("complex pipeline", {

  require(Resonance)

  A <- list()
  SI(A) <- list(
    type='channels',
    channels= 2,
    samplingRate= 20,
    online = T
  )

  code <- "
    prepare = {
  require(Resonance)

  RMS <- function(input, windowSize = 100, windowStep=50){
  wnd <- pipe.windowizer(input, windowSize, windowStep)
  calcRMS(wnd)
  }

  calcRMS <- function(input){
  processor(
  input,
  prepare = function(env){
  SI.is.window(input) || stop('Input must be window')
  SI.channels(1, samplingRate = SI(input)$samplingRate)
  },
  online = function(data){
  ret <- sapply(data, function(wnd){
  sqrt(sum(wnd^2)/length(wnd))
  })
  attr(ret, 'TS') <- sapply(data, function(d){
  ts <- attr(d, 'TS')
  tail(ts, 1)
  })
  ret
  }
  )
  }

},
{
src <- input(1);
spat <- RMS(src, 2,2)
createOutput(spat, 'out')
}
  "

  onPrepare(
    list(
      A
    )
    , code
  )
  onDataBlock.double(1, 1:10, 5, 12)
  #onDataBlock(1, matrix(1:10, ncol=2))


})
