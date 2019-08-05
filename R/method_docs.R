# Dummy file for documenting R6 class methods of Petfinder API defined in api.R

#' Returns data on an animal type, or types available from the Petfinder API. This data includes the 
#' available type's coat names and colors, gender and other specific information relevant to the 
#' specified type(s). The animal type must be of 'dog', 'cat', 'rabbit', 'small-furry', 'horse', 'bird', 
#' 'scales-fins-other', 'barnyard'.
#' 
#' @param types Specifies the animal type or types to return. Can be a character vector representing a single animal type, or a 
#' vector or list of animal types if more than one type is desired. If not specified, all animal types are returned.
#' @return List of returned JSON data for each specified animal type from the Petfinder API.
#' @examples 
#' \dontrun{
#' pf <- Petfinder(key=key, secret=secret) # Initialize Petfinder class
#' cat <- pf$animal_types(types='cat')
#' cat_dog <- pf$animal_types(types=c('cat', 'dog'))
#' all_types <- pf$animal_types()
#' }
animal_types <- function(types=NULL) {
  return(NULL)
}


#' Returns breed names of specified animal type, or types.
#'
#' @param types Specifies the animal type or types. Can be a character vector representing a single animal type, or a 
#' vector or list of animal types if more than one type is desired.If not specified, all available breeds for each animal type is returned. The animal type must be of 'dog', 'cat', 'rabbit', 'small-furry', 'horse', 'bird', 'scales-fins-other', 'barnyard'.
#' @param return_df If TRUE, the result set will be coerced into a pandas data.frame with two columns, breed and name. 
#' @return List of returned JSON data of available breeds for each specified animal type from the Petfinder API. If the parameter return_df 
#'   is TRUE, a data.frame is returned instead.
#' @examples
#' \dontrun{
#' pf <- Petfinder(key=key, secret=secret) # Initialize Petfinder class
#' cat_breeds <- pf$breeds('cat')
#' cat_dog_breeds <- pf$breeds(c('cat', 'dog'))
#' all_breeds <- pf$breeds()
#' all_breeds_df <- pf$breeds(return_df=TRUE)
#' }
breeds <- function(types, return_df=TRUE) {
  return(NULL)
}


#' Returns adoptable animal data from Petfinder based on specified criteria.
#' 
#' @param animal_id Integer or vector or list of integers representing animal IDs obtained from Petfinder. 
#' When animal_id is specified, the other function parameters are overridden. If animal_id is not specified, 
#' a search of animals on Petfinder matching given criteria is performed.
#' @param animal_type Character vector representing desired animal type to search. Must be one of 'dog', 'cat', 
#' 'rabbit', 'small-furry', 'horse', 'bird', 'scales-fins-other', or 'barnyard'.
#' @param breed Character vector or vector or list of character strings of desired animal type breed to search. 
#' Available animal breeds in the Petfinder database can be found using the :code:`breeds()` method.
#' @param size Character vector or vector or list of character strings of desired animal sizes to return. 
#' The specified size(s) must be one of 'small', 'medium', 'large', or 'xlarge'.
#' @param gender Character vector or vector or list of strings representing animal genders to return. 
#' Must be of 'male', 'female', or 'unknown'.
#' @param age Character or vector or list of strings specifying animal age(s) to return from search. Must be 
#' of 'baby', 'young', 'adult', 'senior'.
#' @param color String representing specified animal 'color' to search. Colors for each available animal type in the 
#' Petfinder database can be found using the animal_types() method.
#' @param coat Desired coat(s) to return. Must be of 'short', 'medium', 'long', 'wire', 'hairless', or 'curly'.
#' @param status Animal status to filter search results. Must be one of 'adoptable', 'adopted', or 'found'.
#' @param name Searches for animal names matching or partially matching name.
#' @param organization_id Returns animals associated with given :code:`organization_id`. Can be a vector or a vector 
#' or list of character strings representing multiple organizations.
#' @param location Returns results by specified location. Must be in the format 'city, state' for city-level results, 
#' 'latitude, longitude' for lat-long results, or 'postal code'.
#' @param distance Returns results within the distance of the specified location. If not given, defaults to 100 miles. 
#' Maximum distance range is 500 miles.
#' @param sort Sorts by specified attribute. Leading dashes represents a reverse-order sort. Must be one of 
#' 'recent', '-recent', 'distance', or '-distance'.
#' @param pages Specifies which page of results to return. Defaults to the first page of results. If set to 
#' NULL, all results will be returned.
#' @param results_per_page Number of results to return per page. Defaults to 20 results and cannot exceed 100 
#' results per page.
#' @param return_df If TRUE, a data.frame will be returned. Does not currently do anything.
#' @return List of JSON data of resulting animals.
#' @examples
#' \dontrun{
#' pf <- Petfinder(key=key, secret=secret) # Initialize Petfinder class
#' pf$animals(results_per_page = 100, pages = 10)
#' pf$animals(location='Seattle, WA', distance = 100, results_per_page = 50, pages = 5)
#' pf$animals(animal_id=c(animalid1, animalid2, animalid3))
#' }
animals <- function(animal_id = NULL, 
                    animal_type = NULL, 
                    breed = NULL, 
                    size = NULL, 
                    gender = NULL, 
                    age = NULL, 
                    color = NULL, 
                    coat = NULL, 
                    status = NULL, 
                    name = NULL, 
                    organization_id = NULL, 
                    location = NULL, 
                    distance = NULL, 
                    sort = NULL, 
                    pages = 1,
                    results_per_page = 20, 
                    return_df = FALSE) {
  return(NULL)
}


#' Returns data on an animal welfare organization, or organizations, based on specified criteria.
#'
#' @param organization_id Returns results for specified :code:`organization_id`. Can be a character 
#' vector or a vector or list of character vectors representing multiple organizations.
#' @param name Returns results matching or partially matching organization name.
#' @param location Returns results by specified location. Must be in the format 'city, state' 
#' for city-level results, 'latitude, longitude' for lat-long results, or 'postal code'.
#' @param distance Returns results within the distance of the specified location. If not given, 
#' defaults to 100 miles. Maximum distance range is 500 miles.
#' @param state Filters the results by the selected state. Must be a two-letter state code abbreviation of the state 
#' name, such as 'WA' for Washington or 'NY' for New York.
#' @param country Filters results to specified country. Must be a two-letter abbreviation of the country and is limited 
#' to the United States and Canada.
#' @param query Search matching and partially matching name, city or state.
#' @param sort Sorts by specified attribute. Leading dashes represents a reverse-order sort. Must be one of 'recent', '-recent', 'distance', or '-distance'.
#' @param pages Specifies which page of results to return. Defaults to the first page of results. If set to NULL, all results will be returned.
#' @param results_per_page Number of results to return per page. Defaults to 20 results and cannot exceed 100 results per page.
#' @param return_df If TRUE, the results will be returned as a data.frame. Currently does not do anything.
#' @return List of returned JSON data of organizations matching given search criteria.
#' @examples
#' \dontrun{
#' pf <- Petfinder(key=key, secret=secret) # Initialize Petfinder class
#' pf$organizations(state='WA', results_per_page = 100, pages = 2)
#' pf$organizations(organization_id=c(orgid1, orgid2, orgid3))
#' }
organizations <- function(organization_id = NULL,
                          name = NULL, 
                          location = NULL,
                          distance = NULL,
                          state = NULL,
                          country = NULL,
                          query = NULL,
                          sort = NULL, 
                          results_per_page = 20,
                          pages = 1, 
                          return_df = FALSE) {
  return(NULL)
}
