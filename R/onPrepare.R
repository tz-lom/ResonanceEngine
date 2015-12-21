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

  input <- function(index) {
    inputs[[index]]
  }

  .globals$env$input <- input
  eval(.globals$process, envir = .globals$env)

if(is.function(.globals$env$process)) {
    .globals$env$process()
  }
}
