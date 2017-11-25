

Petfinder <- function(key, secret = NULL) {
  auth <- .Petfinder.class$new(key, secret)
  
  return(auth)
}

.Petfinder.class <- R6Class("Petfinder",

  public = list(
    key = NULL,
    secret = NULL,
    host = NULL,
    
    initialize = function(key, secret = NULL) {
      
      self$key <- key
      self$secret <- secret
      self$host <- 'http://api.petfinder.com/'
      
    },

    breed.list = function(animal, outputformat = 'json') {
      
      url <- paste0(self$host, 'breed.list', sep = '')
      params <- private$parameters(key = self$key, 
                                   animal = animal, 
                                   outputformat = outputformat)

      breeds <- private$return_json(url, params)

      breeds <- breeds$petfinder$breeds$breed
      colnames(breeds) <- paste0(animal, 'breeds', sep = ' ')
      
      return(breeds)
    },
    
    pet.get = function(petId, 
                       outputformat = 'json') {
      
      url <- paste0(self$host, 'pet.get', sep = '')
      params <- private$parameters(key = self$key,
                                   id = petId,
                                   outputformat = outputformat)
      
      if (is.list(petId) | is.vector(petId)) {
        
        pets <- lapply(petId, function(x) {
          params['id'] <- x
          pet_record(private$return_json(url, params)$petfinder$pet)
        })
        
        r <- rbind.list(pets)
        
      }
      
      else {
        r <- private$return_json(url, params)
        r <- pet_record(r$petfinder$pet)
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
                             output = NULL,
                             outputformat = 'json') {
      
      url <- paste0(self$host, 'pet.getRandom', sep = '')
      params <- private$parameters(key = self$key,
                                   animal = animal,
                                   breed = breed,
                                   size = size,
                                   sex = sex,
                                   location = location,
                                   shelterId = shelterId,
                                   output = output,
                                   outputformat = outputformat)
      
      if (!is.null(records)) {
        rvec <- list()
      
        for (i in 1:records) {
          rvec[[i]] <- pet_record(private$return_json(url, params)$petfinder$pet)
        }
      
        r <- rbind.fill(rvec)
      }
      
      else {
        r <- pet_record(private$return_json(url, params)$petfinder$pet)
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
                        outputformat = 'json') {
      
      url <- paste0(self$host, 'pet.find', sep = '')
      params <- private$parameters(key = self$key,
                                   location = location,
                                   animal = animal,
                                   breed = breed,
                                   size = size,
                                   sex = sex,
                                   age = age,
                                   offset = offset,
                                   count = count,
                                   output = output,
                                   outputformat = outputformat)
      
      r <- private$return_json(url, params)
      
      if (r$petfinder$lastOffset$`$t` == '1') {
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
                            outputformat = 'json') {
      
      url <- paste0(self$host, 'shelter.find', sep = '')
      params <- private$parameters(key = self$key,
                                   location = location,
                                   name = name,
                                   offset = offset,
                                   count = count,
                                   outputformat = outputformat)
      
      r <- private$return_json(url, params)
      
      return(r)
      
    },
    
    shelter.get = function(shelterId,
                           outputformat = 'json') {
      
      url <- paste0(self$host, 'shelter.get', sep = '')
      params <- private$parameters(key = self$key,
                                   id = shelterId,
                                   outputformat = outputformat)
      
      r <- private$return_json(url, params)
      
      return(r)
      
    },
    
    shelter.getPets = function(shelterId,
                               status = NULL,
                               offset = NULL,
                               count = NULL,
                               output = NULL,
                               outputformat = 'json') {
      
      url <- paste0(self$host, 'shelter.getPets', sep = '')
      params <- private$parameters(key = self$key,
                                   id = shelterId,
                                   status = status,
                                   offset = offset,
                                   count = count,
                                   output = output,
                                   outputformat = outputformat)
      
      r <- private$return_json(url, params)
      
      return(r)
      
    },
    
    shelter.listByBreed = function(animal,
                                   breed,
                                   offset = NULL,
                                   count = NULL,
                                   outputformat = 'json') {
      
      url <- paste0(self$host, 'shelter.listByBreed', sep = '')
      params <- private$parameters(key = self$key,
                                   animal = animal,
                                   breed = breed,
                                   offset = offset,
                                   count = count,
                                   outputformat = outputformat)
      
      r <- private$return_json(url, params)
      
      return(r)
      
    }
  ), 
  
  private = list(
    
    parameters = function(key,
                          animal = NULL,
                          breed = NULL,
                          size = NULL,
                          sex = NULL,
                          location = NULL,
                          name = NULL,
                          age = NULL,
                          petId = NULL,
                          shelterId = NULL,
                          status = NULL,
                          output = NULL,
                          outputformat = 'json',
                          offset = NULL,
                          count = NULL,
                          id = NULL) {
      
      params <- list('key' = key,
                     'animal' = animal,
                     'breed' = breed,
                     'size' = size,
                     'sex' = sex,
                     'age' = age,
                     'location' = location,
                     'name' = name,
                     'petId' = petId,
                     'shelterId' = shelterId,
                     'status' = status,
                     'output' = output,
                     'format' = outputformat,
                     'offset' = offset,
                     'count' = count,
                     'id' = id
      )
      
      params <- params[!sapply(params, is.null)]
      return(params)
      
    },
    
    return_json = function(url, params) {
      url <- parse_url(url)
      url$query <- params
      url <- build_url(url)
      
      json_url <- fromJSON(url)
      
      return(json_url)
    }
  )
)