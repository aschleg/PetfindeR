
#' Creates an authenticated connection with the Petfinder API. The stored
#' authentication is then used to call the Petfinder API methods. An API key can
#' be obtained from Petfinder by creating an account on their developer page
#' (https://www.petfinder.com/developers/api-key). The function wraps the
#' .Petfinder.class R6 class.
#' 
#' @param key The API key received from Petfinder
#' @param secret The secret key received from Petfinder along with the API key.
#'   Only used for methods that require additional authentication (not currently
#'   used).
#' @return Intialized Petfinder object that is then used to access the API.
#' @examples 
#' \dontrun{
#' pf <- Petfinder(key) # Creates the connection with the Petfinder API.
#' pf$breed.list('cat') # The connection can now be used to access the Petfinder API methods.
#' }
#' @export
Petfinder <- function(key, secret = NULL) {
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
      self$host <- 'http://api.petfinder.com/'
      
    },

    breed.list = function(animal) {
      check_inputs(animal=animal)
      
      url <- paste0(self$host, 'breed.list', sep = '')
      params <- parameters(key = self$key, 
                           animal = animal)

      breeds <- return_json(url, params)

      # breeds <- breeds$petfinder$breeds$breed
      # colnames(breeds) <- paste0(animal, '.breeds', sep = '')
      
      return(breeds)
    },
    
    pet.get = function(petId) {
      
      url <- paste0(self$host, 'pet.get', sep = '')
      params <- parameters(key = self$key,
                                   id = petId)
      
      if (length(petId) > 1) {
        pets <- sapply(as.vector(petId), function(x) {
          params['id'] <- x
          return_json(url, params)
        })
      }
      else {
        pets <- return_json(url, params)
      }
      
      return(pets)
    },
    
    pet.getRandom = function(records = NULL,
                             animal = NULL,
                             breed = NULL,
                             size = NULL,
                             sex = NULL,
                             location = NULL,
                             shelterId = NULL,
                             output = NULL) {
      
      check_inputs(animal = animal, size = size, sex = sex)
      
      url <- paste0(self$host, 'pet.getRandom', sep = '')
      params <- parameters(key = self$key,
                                   animal = animal,
                                   breed = breed,
                                   size = size,
                                   sex = sex,
                                   location = location,
                                   shelterId = shelterId,
                                   output = output)
      
      if (!is.null(records)) {
        pets <- list()
      
        for (i in 1:records) {
          pets[[i]] <- return_json(url, params)
        }
      }
      else {
        pets <- return_json(url, params)
      }
      
      return(pets)
    },
    
    pet.find = function(location,
                        animal = NULL,
                        breed = NULL,
                        size = NULL,
                        sex = NULL,
                        age = NULL,
                        offset = NULL,
                        count = NULL,
                        output = NULL,
                        pages = NULL) {
      
      check_inputs(animal = animal, size = size, sex = sex, age = age)
      
      url <- paste0(self$host, 'pet.find', sep = '')
      params <- parameters(key = self$key,
                           location = location,
                           animal = animal,
                           breed = breed,
                           size = size,
                           sex = sex,
                           age = age,
                           offset = offset,
                           count = count,
                           output = output,
                           pages = pages)
      
      r <- return_json(url, params)
      
      if (!is.null(pages)) {
        r <- paged_result(r = r, url = url, params = params)
      }
      
      return(r)
    },
    
    shelter.find = function(location,
                            name = NULL,
                            offset = NULL,
                            count = NULL,
                            pages = NULL) {
      
      url <- paste0(self$host, 'shelter.find', sep = '')
      params <- parameters(key = self$key,
                                   location = location,
                                   name = name,
                                   offset = offset,
                                   count = count,
                                   pages = pages)
      
      r <- return_json(url, params)
      
      if (!is.null(pages)) {
        r <- paged_result(r = r, url = url, params = params)
      }
      
      return(r)
    },
    
    shelter.get = function(shelterId) {
      
      url <- paste0(self$host, 'shelter.get', sep = '')
      params <- parameters(key = self$key, id = shelterId)
      
      if (length(shelterId) > 1) {
        shelters <- sapply(shelterId, function(x) {
          params['id'] <- x
          return_json(url, params)
        })
      }
      else {
        shelters <- return_json(url, params)
      }
      
      return(shelters)
    },
    
    shelter.getPets = function(shelterId,
                               status = NULL,
                               offset = NULL,
                               count = NULL,
                               output = NULL,
                               pages = NULL) {
      
      url <- paste0(self$host, 'shelter.getPets', sep = '')
      params <- parameters(key = self$key,
                           id = shelterId,
                           status = status,
                           offset = offset,
                           count = count,
                           output = output,
                           pages = pages)
      
      r <- return_json(url, params)
      
      if (!is.null(pages)) {
        r <- paged_result(r = r, url = url, params = params)
      }
      
      return(r)
    },
    
    shelter.listByBreed = function(animal,
                                   breed,
                                   offset = NULL,
                                   count = NULL,
                                   pages = NULL) {
      
      check_inputs(animal = animal)
      
      url <- paste0(self$host, 'shelter.listByBreed', sep = '')
      params <- parameters(key = self$key,
                           animal = animal,
                           breed = breed,
                           offset = offset,
                           count = count,
                           pages = pages)
      
      r <- return_json(url, params)
      
      return(r)
    }
  )
)


return_json = function(url, params) {
  params['format'] = 'json'
  url <- httr::parse_url(url)
  url$query <- params
  url <- httr::build_url(url)
  
  json_url <- jsonlite::fromJSON(url)
  
  return(json_url)
}