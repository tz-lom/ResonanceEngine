onPrepare <- function(inputs, code){

  if(is.function(globalenv()$onPrepare)) {
    globalenv()$onPrepare()
  }

  Resonance:::.reset_processor_cache()

  resetGlobals();

  if(is.language(code)){
    eval(code, envir = .globals$env)
  }else{
    eval(parse(text=code), envir = .globals$env)
  }

  .globals$inputs <- lapply(inputs, SI)

  .globals$emptyInputs <- lapply(inputs, function(input){
    if(SI.is.channels(input)){
      ret <- matrix(ncol=SI(input)$channels, nrow=0)
      SI(ret) <- SI(input)
      return(ret)
    }
    if(SI.is.event(input))
    {
      ret <- list()
      SI(ret) <- SI(input)
      return(ret)
    }
  })

  input <- function(index) {
    inputs[[index]]
  }

  .globals$env$input <- input
  eval(.globals$process, envir = .globals$env)

if(is.function(.globals$env$process)) {
    .globals$env$process()
  }
}
