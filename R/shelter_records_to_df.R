

shelter_records_to_df = function(r) {
  
  df <- data.frame(lapply(r, function(x) {
    if (dim(x)[2] == 0) {
      x <- NA
    }
    else {
      x
    }
  }))
  
  colnames(df) <- names(r)
  
  return(df)
}