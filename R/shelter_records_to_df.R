

shelter_records_to_df = function(r) {
  
  df <- data.frame(lapply(r, function(x) {
    
    if (is.null(dim(x))) {
      tryCatch(
        x[[1]],
        error = function(cond) {
          x <- NA
        }
      )
    }

    else if (dim(x)[2] == 0) {
      x <- NA
    }
    
    else {
      x
    }
  }))
  
  colnames(df) <- names(r)
  
  return(df)
}