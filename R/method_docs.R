# Dummy file for documenting R6 class methods of Petfinder API defined in api.R


#' Method for calling the 'breed.list' method of the Petfinder API. Returns the
#' available breeds for the selected animal.
#' 
#' @param animal Return breeds of animal. Must be one of 'barnyard', 'bird',
#'   'cat', 'dog', 'horse', 'reptile', or 'smallfurry'
#' @param outputformat Output type of results. Must be one of 'json' (default)
#'   or 'xml'
#' @return The breeds of the animal. If the parameter :code:`outputformat` is
#'   'json', the result is formatted as a JSON object. Otherwise, the return
#'   object is a text representation of an XML object.
#' @examples
#' pf <- Petfinder(key)
#' pf$breed.list('cat')
#' pf$breed.list('dog', 'xml')
breed.list <- function(animal, outputformat = 'json') {
  return(NULL)
}


#' Returns a single record for a pet.
#' 
#' @param petId ID of the pet record to return.
#' @param outputformat Output type of results. Must be one of 'json' (default) or 'xml'
#' @return Matching record corresponding to input pet ID. If the parameter :code:`outputformat` is 'json',the result is formatted as a JSON object. Otherwise, the return object is a text representation of an XML object.
#' @examples 
#' pf <- Petfinder(key)
#' pf$pet.get(petId)
pet.get <- function(petId, outputformat = 'json') {
  return(NULL)
}
