
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
#' pf$breeds('cat') # The connection can now be used to access the Petfinder API methods.
#' }
#' @export
Petfinder <- function(key, secret) {
  auth <- .Petfinder.class$new(key, secret)
  
  return(auth)
}


#' Internal R6 class
.Petfinder.class <- R6::R6Class(".Petfinder.class",

  public = list(

    initialize = function(key, secret) {
      
      private$key <- key
      private$secret <- secret
      private$host <- 'https://api.petfinder.com/v2/'
      private$auth <- private$authenticate()
      
    },
    
    animal_types = function(types = NULL) {
      all_types <- c('dog', 'cat', 'rabbit', 'small-furry', 'horse', 'bird',
                     'scales-fins-other', 'barnyard')
      
      if (!is.null(types)) {
        type_check <- types
        
        differ <- setdiff(type_check, all_types)
        
        if (length(differ) > 1) {
          stop(paste0("animal types must be of the following", all_types, collapse = ' '))
        }
      }
        
      if (is.null(types)) {
        types <- all_types
      }
      
      if (is.vector(types) || is.list(types)) {
        types_collection = list()
        
        for (type in types) {
          url <- paste0(private$host, 'types/', type, sep = '')
          
          r <- httr::GET(url, 
                         httr::add_headers(Authorization = paste0('Bearer ', 
                                                                  private$auth, sep = '')))

          req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'))$type
          req_json$`_links` <- NULL

          types_collection[[req_json$name]] <- req_json

        }
      }
        
      else {
        stop('types parameter must be either NULL, character, a vector, or a list.')
      }
      
      return(types_collection)
      
    },
    
    breeds = function(animal_types = NULL, return_df = FALSE) {
      all_animal_types <- c('dog', 'cat', 'rabbit', 'small-furry', 
                            'horse', 'bird', 'scales-fins-other', 'barnyard')
      
      if (!is.null(animal_types)) {
        type_check <- animal_types
        
        differ <- setdiff(type_check, all_animal_types)
        
        if (length(differ) > 1) {
          stop(paste0("animal types must be of the following", all_animal_types, collapse = ' '))
        }
      }
      
      if (is.null(animal_types)) {
        animal_types <- all_animal_types
      }
      
      if (is.vector(animal_types) || is.list(animal_types)) {
        breeds_collection = list()
        
        for (type in animal_types) {
          url <- paste0(private$host, 'types/', type, '/breeds', sep = '')
          
          r <- httr::GET(url, 
                         httr::add_headers(Authorization = paste0('Bearer ', 
                                                                  private$auth, sep = '')))
          
          req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'))$breeds$name
          breeds_collection[[type]] <- req_json
          
        }
      }
      
      if (return_df == TRUE) {
        breeds_collection_df <- data.frame()
        type_names <- names(breeds_collection)
        
        for (type in seq_along(breeds_collection)) {
          df <- data.frame(rep(type_names[type], length(breeds_collection[[type]])), 
                           breeds_collection[[type]], stringsAsFactors = FALSE)
          
          names(df) <- c('animal', 'breeds')
          breeds_collection_df <- dplyr::bind_rows(breeds_collection_df, df)
        }
        
        breeds_collection <- breeds_collection_df
        
      }
      
      return(breeds_collection)
      
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
      return(NULL)
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
      return(NULL)
    }
  ),
  private = list(
    key = NULL,
    secret = NULL,
    host = NULL,
    auth = NULL,
    
    authenticate = function() {
      endpoint <- 'oauth2/token'
      url <- paste0(private$host, endpoint, sep = '')
      req <- httr::POST(url, 
                        body = list("grant_type"="client_credentials", "client_id" = private$key, 
                                    "client_secret" = private$secret)
      );
      
      return(httr::content(req)$access_token)
    },
    
    return_json = function(url, params) {
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
