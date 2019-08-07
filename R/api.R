require(R6)


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
.Petfinder.class <- R6Class(".Petfinder.class",

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

          req_json <- jsonlite::fromJSON(httr::content(r, as = 'text', encoding = 'utf-8'))$type
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
      
      animals_list <- list()
      
      if (!is.null(animal_id)) {

        if (is.vector(animal_id) || is.list(animal_id)) { 
          
          for (ani_id in animal_id) {
            url <- paste0(private$host, 'animals/', ani_id, sep = '')
            
            r <- httr::GET(url, 
                           httr::add_headers(Authorization = paste0('Bearer ', 
                                                                    private$auth, sep = '')))
            
            req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'), 
                                           flatten = TRUE)$animal
            
            animals_list[[as.character(ani_id)]] <- req_json
            
          }
        }
      }
      
      else {
        url <- paste0(private$host, 'animals/', sep = '')
        
        params <- private$parameters(animal_type = animal_type,
                                     breed = breed,
                                     size = size,
                                     gender = gender,
                                     age = age,
                                     color = color,
                                     coat = coat,
                                     status = status,
                                     name = name,
                                     organization_id = organization_id,
                                     location = location,
                                     distance = distance,
                                     sort = sort,
                                     results_per_page = results_per_page
                                     )
        
        if (is.null(pages)) {
          params['limit'] = 100
          params['page'] = 1
          
          r <- httr::GET(url, 
                         query = params,
                         httr::add_headers(Authorization = paste0('Bearer ', 
                                                                  private$auth, sep = '')))
          
          req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'), 
                                         flatten = TRUE)
          
          animals_list[[paste0('page', as.character(1), sep = '')]] <- req_json$animals
          max_pages <- req_json$pagination$total_pages
          
          for (page in 2:max_pages) {
            params['page'] <- page
            
            r <- httr::GET(url, 
                           query = params,
                           httr::add_headers(Authorization = paste0('Bearer ', 
                                                                    private$auth, sep = '')))
            
            req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'), 
                                           flatten = TRUE)
            
            animals_list[[paste0('page', as.character(page), sep='')]] <- req_json$animals
            
          }
          
        }
        
        else {
          params['page'] = 1
          
          r <- httr::GET(url, 
                         query = params,
                         httr::add_headers(Authorization = paste0('Bearer ', 
                                                                  private$auth, sep = '')))
          
          req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'))
          
          animals_list[[paste0('page', as.character(1), sep='')]] <- req_json$animals
          
          if (pages == 1) {
            return(animals_list)
          }
          
          max_pages <- req_json$pagination$total_pages
          
          if (pages > max_pages) {
            pages <- max_pages
            max_page_warning = TRUE
          }
          
          for (page in 2:pages) {
            params['page'] = page
            
            r <- httr::GET(url, 
                           query = params,
                           httr::add_headers(Authorization = paste0('Bearer ', 
                                                                    private$auth, sep = '')))
            
            req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'), 
                                           flatten = TRUE)
            
            animals_list[[paste0('page', as.character(page), sep='')]] <- req_json$animals
            
          }
        }
      }
      
      if (return_df == TRUE) {
        
      }
      
      return(animals_list)
      
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
      
      organizations_list <- list()
      
      if (!is.null(organization_id)) {
        
        if (is.vector(organization_id) || is.list(organization_id)) {
          
          for (org_id in organization_id) {
            url <- paste0(private$host, 'organizations/', org_id, sep = '')
            
            r <- httr::GET(url, 
                           httr::add_headers(Authorization = paste0('Bearer ', 
                                                                    private$auth, sep = '')))
            
            req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'), 
                                           flatten = TRUE)$organization
            
            organizations_list[[as.character(org_id)]] <- req_json
          }
        }
      }
      
      else {
        url <- paste0(private$host, 'organizations/', sep = '')
        
        params <- private$parameters(name = name,
                                     location = location, 
                                     distance = distance, 
                                     state = state,
                                     country = country,
                                     query = query, 
                                     sort = sort,
                                     results_per_page = results_per_page)
        
        if (is.null(pages)) {
          params['limit'] = 100
          params['page'] = 1
          
          r <- httr::GET(url, 
                         query = params,
                         httr::add_headers(Authorization = paste0('Bearer ', 
                                                                  private$auth, sep = '')))
          
          req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'), 
                                         flatten = TRUE)
          
          max_pages <- req_json$pagination$total_pages
          
          for (page in 2:max_pages) {
            params['page'] = page
            
            r <- httr::GET(url, 
                           query = params,
                           httr::add_headers(Authorization = paste0('Bearer ', 
                                                                    private$auth, sep = '')))
            
            req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'), 
                                           flatten = TRUE)$organizations
            
            organizations_list[[paste0('page', as.character(page), sep = '')]] <- req_json
            
          }
        }
        
        else {
          params['page'] = 1
          
          r <- httr::GET(url, 
                         query = params,
                         httr::add_headers(Authorization = paste0('Bearer ', 
                                                                  private$auth, sep = '')))
          
          req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'), 
                                         flatten = TRUE)
          
          organizations_list[[paste0('page', as.character(1), sep = '')]] <- req_json$organizations
          
          if (pages == 1) {
            return(organizations_list)
          }
          
          max_pages <- req_json$pagination$total_pages
          
          if (pages > max_pages) {
            pages <- max_pages
            max_page_warning <- TRUE
          }
          
          for (page in 2:pages) {
            params['page'] = page
            
            r <- httr::GET(url, 
                           query = params,
                           httr::add_headers(Authorization = paste0('Bearer ', 
                                                                    private$auth, sep = '')))
            
            req_json <- jsonlite::fromJSON(httr::content(r, as='text', encoding = 'utf-8'), 
                                           flatten = TRUE)
            
            organizations_list[[paste0('page', as.character(page), sep = '')]] <- req_json$organizations
            
          }
        }
      }
      
      if (return_df == TRUE) {
        
      }
    
      return(organizations_list)
    
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
    
    parameters = function(breed = NULL,
                          size = NULL,
                          gender = NULL,
                          color = NULL,
                          coat = NULL,
                          animal_type = NULL,
                          location = NULL,
                          distance = NULL,
                          state = NULL,
                          country = NULL,
                          query = NULL,
                          sort = NULL,
                          name = NULL,
                          age = NULL,
                          animal_id = NULL,
                          organization_id = NULL,
                          status = NULL,
                          results_per_page = NULL,
                          page = NULL) {
      
      params <- list('breed' = breed,
                     'size' = size,
                     'gender' = gender,
                     'color' = color,
                     'coat' = coat,
                     'animal_type' = animal_type,
                     'location' = location,
                     'distance' = distance,
                     'state' = state,
                     'country' = country,
                     'query' = query,
                     'sort' = sort,
                     'name' = name,
                     'age' = age,
                     'animal_id' = animal_id,
                     'organization_id' = organization_id,
                     'status' = status,
                     'limit' = results_per_page,
                     'page' = page
      )
      
      params <- params[!sapply(params, is.null)]
      
      return(params)
    }, 
    
    check_inputs = function(animal_types = NULL, 
                            size = NULL, 
                            gender = NULL, 
                            age = NULL, 
                            coat = NULL,
                            status = NULL,
                            distance = NULL,
                            sort = NULL,
                            limit = NULL) {
      
      .animal_types <- c('dog', 'cat', 'rabbit', 'small-furry', 
                         'horse', 'bird', 'scales-fins-other', 'barnyard')
      .sizes <- c('small', 'medium', 'large', 'xlarge')
      .genders <- c('male', 'female', 'unknown')
      .ages <- c('baby', 'young', 'adult', 'senior')
      .coats <- c('short', 'medium', 'long', 'wire', 'hairless', 'curly')
      .status <- c('adoptable', 'adopted', 'found')
      .sort <- c('recent', '-recent', 'distance', '-distance')
      
      if (!is.null(animal_types)) {
        if (!animal_types %in% .animal_types) {
          stop(paste0('The following animal type options are valid: ', 
                      paste0(.animal_types, collapse = ', ')))
        }
      }
      
      if (!is.null(size)) {
        if (!size %in% .sizes) {
          stop(paste0('The following animal size options are valid: ', 
                      paste0(.sizes, collapse = ', ')))
        }
      }
      
      if (!is.null(gender)) {
        if (!gender %in% .genders) {
          stop(paste0('The following gender options are valid: ', paste0(.genders, collapse = ', ')))
        }
      }
      
      if (!is.null(age)) {
        if (!age %in% .ages) {
          stop(paste0('The following animal age options are valid: ', paste0(.ages, collapse = ', ')))
        }
      }
      
      if (!is.null(coat)) {
        if (!coat %in% .coats) {
          stop(paste0('The following coat options are valid: ', paste0(.coats, collapse = ', ')))
        }
      }
      
      if (!is.null(status)) {
        if (!status %in% .status) {
          stop(paste0('The following status options are valid: ', paste0(.status, collapse = ', ')))
        }
      }
      
      if (!is.null(sort)) {
        if (!sort %in% .sort) {
          stop(paste0('The following sorting options are valid: ', paste0(.sort, collapse = ', ')))
        }
      }
      
      if (!is.null(distance)) {
        if (0 > as.integer(distance) || as.integer(distance) > 500) {
          stop('distance cannot be greater than 500 or less than 0.')
        }
      }
      
      if (!is.null(limit)) {
        if (as.integer(limit) > 100) {
          stop('results per page cannot be greater than 100.')
        } 
      }
      
    }
  )
)
