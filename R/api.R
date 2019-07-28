
#' Creates an authenticated connection with the Petfinder API. The stored
#' authentication is then used to call the Petfinder API methods. An API key can
#' be obtained from Petfinder by creating an account on their developer page
#' (https://www.petfinder.com/developers/api-key). The function wraps the
#' .Petfinder.class R6 class.
#' 
#' @param key The API key received from Petfinder
#' @param secret The secret key received from Petfinder along with the API key.
#' @return Intialized Petfinder object that is then used to access the API.
#' @examples 
#' \dontrun{
#' pf <- Petfinder(key) # Creates the connection with the Petfinder API.
#' pf$breed.list('cat') # The connection can now be used to access the Petfinder API methods.
#' }
#' @export
Petfinder <- function(key, secret) {
  auth <- .Petfinder.class$new(key, secret)
  
  return(auth)
}


#' Internal R6 class
.Petfinder.class <- R6::R6Class(".Petfinder.class",

  public = list(
    key = NULL,
    secret = NULL,
    host = NULL,
    
    initialize = function(key, secret = NULL) {
      
      self$key <- key
      self$secret <- secret
      self$host <- 'https://api.petfinder.com/v2/'
      self$auth <- self$authenticate(key = self$key, secret = self$secret)
      
    },
    
    animal_types = function(types, return_df = FALSE) {
      
    },
    
    breeds = function(animal_types, return_df = FALSE) {

    },
    
    animals = function(animal_id = NULL, 
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
      
    },
    
    organizations = function(organization_id = NULL,
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
      
    }
  ),
  private = list(
    authenticate = function(key, secret) {
      endpoint <- 'oauth2/token'
      url <- paste0(self$host, endpoint, sep = '')
      req <- httr::POST(url, 
                        body = list("grant_type"="client_credentials", "client_id" = key, 
                                    "client_secret" = secret)
      );
      
      return(httr::content(req)$access_token)
    },
    
    return_json = function(url, params) {
      params['format'] = 'json'
      url <- httr::parse_url(url)
      url$query <- params
      url <- httr::build_url(url)
      
      json_url <- jsonlite::fromJSON(url, flatten = TRUE, 
                                     simplifyDataFrame = TRUE, 
                                     simplifyMatrix = TRUE, 
                                     simplifyVector = TRUE)
      
      return(json_url)
    }
  )
)
