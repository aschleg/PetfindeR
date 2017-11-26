

paged_result = function(r, element, url, params) {
  if (is.null(params[['count']])) {
    count <- 25
  }
  
  pages <- params[['pages']]
  
  lastOffset <- r$petfinder$lastOffset$`$t`
  
  pageresults <- list()
  pageresults[[1]] <- element
  
  for (i in 1:pages) {
    params['lastOffset'] <- lastOffset
    r <- return_json(url, params)
    
    lastOffset <- r$petfinder$lastOffset$`$t`
    pageresults[[i+1]] <- element
    
    if (as.integer(lastOffset) + count >= 2000) {
      warning(paste('Next result set would exceed maximum 2,000 records per search, returning results up to page', as.character(pages - 1)))
      return(pageresults)
    }
  }
  return(pageresults)
}
