
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

      breeds <- breeds$petfinder$breeds$breed
      colnames(breeds) <- paste0(animal, '.breeds', sep = '')
      
      return(breeds)
    },
    
    pet.get = function(petId) {
      
      url <- paste0(self$host, 'pet.get', sep = '')
      params <- parameters(key = self$key,
                                   id = petId)
      
      if (length(petId) > 1) {
        
        pets <- sapply(as.vector(petId), function(x) {
          params['id'] <- x
          pet_record(return_json(url, params)$petfinder$pet)
        })
        
        r <- plyr::rbind.fill(pets)
      }
      
      else {
        r <- pet_record(return_json(url, params)$petfinder$pet)
      }
      return(r)
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
        rvec <- list()
      
        for (i in 1:records) {
          rvec[[i]] <- pet_record(return_json(url, params)$petfinder$pet)
        }
      
        r <- plyr::rbind.fill(rvec)
      }
      
      else {
        r <- pet_record(return_json(url, params)$petfinder$pet)
      }
      
      return(r)
      
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
        pageresults <- paged_result(r = r, element = r$petfinder$pets$pet, url = url, params = params)
        
        df <- rbind.fill(lapply(pageresults, function(x) {
          pet_records_df(x)
        }))
        
        return(df)
      }
      
      else if (r$petfinder$lastOffset$`$t` == '1') {
        return(pet_record(r$petfinder$pets$pet))
      }
      
      else {
        return(pet_records_df(r$petfinder$pets$pet))
      }
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
        pageresults <- paged_result(r = r, element = r$petfinder$shelters$shelter, url = url, params = params)
        
        r <- rbind.fill(lapply(pageresults, function(x) {
          shelter_records_to_df(x)
        }))
      }
      
      else {
        r <- shelter_records_to_df(r$petfinder$shelters$shelter)
      }
      return(r)
    },
    
    shelter.get = function(shelterId) {
      
      url <- paste0(self$host, 'shelter.get', sep = '')
      params <- parameters(key = self$key, id = shelterId)
      
      if (is.list(shelterId) | length(shelterId) > 1) {
        
        shelters <- lapply(shelterId, function(x) {
          params['id'] <- x
          shelter_records_to_df(return_json(url, params)$shelter)
        })
        
        r <- plyr::rbind.fill(shelters)
        
      }

      else {
        r <- return_json(url, params)
        r <- shelter_records_to_df(r$petfinder$shelter)
      }
      
      return(r)
    
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
      
      if (r$petfinder$lastOffset$`$t` == '1') {
        return(pet_record(r$petfinder$pets$pet))
      }
      else {
        return(pet_records_df(r$petfinder$pets$pet))
      }
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
      r <- shelter_records_to_df(r$petfinder$shelters$shelter)
      
      return(r)
      
    }
  )
)
