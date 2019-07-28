# Dummy file for documenting R6 class methods of Petfinder API defined in api.R


#' Method for calling the 'breed.list' method of the Petfinder API. Returns the
#' available breeds for the selected animal.
#'
#' @param animal Return breeds of animal. Must be one of 'barnyard', 'bird',
#'   'cat', 'dog', 'horse', 'reptile', or 'smallfurry'.
#' @param return_df If TRUE, the function will coerce the output JSON from the
#'   Petfinder API into a data.frame
#' @return List of returned JSON from the Petfinder API. If the parameter return_df 
#'   is TRUE, a data.frame is returned instead.
#' @examples
#' \dontrun{
#' pf <- Petfinder(key) # Initialize Petfinder class
#' pf$breed.list('cat')
#' pf$breed.list('dog')
#' }
breed.list <- function(animal, return_df=TRUE) {
  return(NULL)
}


#' Returns a data.frame of pet records matching input parameters.
#' 
#' @param location ZIP/postal code, state, or city and state to perform the
#'   search.
#' @param animal Return breeds of animal. Must be one of 'barnyard', 'bird', 
#'   'cat', 'dog', 'horse', 'reptile', or 'smallfurry'.
#' @param breed Specifies the breed of the animal to search.
#' @param size Specifies the size of the animal/breed to search. Must be one of
#'   'S' (small), 'M' (medium), 'L' (large), 'XL' (extra-large).
#' @param sex Filters the search to the desired gender of the animal. Must be
#'   one of 'M' (male) or 'F' (female).
#' @param age Returns animals with specified age. Must be one of 'Baby',
#'   'Young', 'Adult', 'Senior'.
#' @param offset Can be set to the value of lastOffset returned from the
#'   previous call to retrieve the next set of results. The pages parameter can
#'   also be used to pull a desired number of paged results.
#' @param count The number of records to return. Default is 25.
#' @param pages The number of pages of results to return. For example, if
#'   pages=4 with the default count parameter (25), 125 results would be
#'   returned (25 results from first call and 100 from the next four pages).
#' @param output Sets the amount of information returned in each record. 'basic'
#'   returns a simple record while 'full' returns a complete record with
#'   description. Defaults to 'basic'.
#' @param return_df If TRUE, the function will coerce the output JSON from the
#'   Petfinder API into a data.frame
#' @return data.frame of pet records matching input parameters.
#' @examples
#' \dontrun{
#' pf <- Petfinder(key) # Initialize Petfinder class
#' pf$pet.find('WA')
#' pf$pet.find('WA', 'cat', pages = 2)
#' }
pet.find <- function(location,
                     animal = NULL,
                     breed = NULL,
                     size = NULL,
                     sex = NULL,
                     age = NULL,
                     offset = NULL,
                     count = NULL,
                     output = NULL,
                     pages = NULL, 
                     return_df = FALSE) {
  return(NULL)
}


#' Returns a data.frame of shelter records matching input parameters.
#'
#' @param location ZIP/postal code, state, or city and state to perform the
#'   search.
#' @param name Full or partial shelter name
#' @param offset Can be set to the value of lastOffset returned from the
#'   previous call to retrieve the next set of results. The pages parameter can
#'   also be used to pull a desired number of paged results.
#' @param count The number of records to return. Default is 25.
#' @param pages The number of pages of results to return. For example, if
#'   pages=4 with the default count parameter (25), 125 results would be
#'   returned (25 results from first call and 100 from the next four pages).
#' @param return_df If TRUE, the function will coerce the output JSON from the
#'   Petfinder API into a data.frame
#' @return List of returned JSON from the Petfinder API. If the parameter
#'   return_df is TRUE, a data.frame is returned instead.
#' @examples
#' \dontrun{
#' pf <- Petfinder(key) # Initialize Petfinder class
#' pf$shelter.find('WA', count = 5)
#' pf$shelter.find('WA', pages = 3)
#' }
shelter.find <- function(location,
                        name = NULL,
                        offset = NULL,
                        count = NULL,
                        pages = NULL, 
                        return_df = FALSE) {
  return(NULL)
}
