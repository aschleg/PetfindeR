

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
                      offset = NULL,
                      count = NULL,
                      pages = NULL,
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
                 'offset' = offset,
                 'count' = count,
                 'pages' = pages,
                 'id' = id
  )
  
  params <- params[!sapply(params, is.null)]
  return(params)
}


check_inputs <- function(animal=NULL, size=NULL, sex=NULL, age=NULL) {
  
  if (!is.null(animal)) {
    animals <- c('barnyard', 'bird', 'cat', 'dog', 'horse', 'reptile', 'smallfurry')
    
    if (!animal %in% animals) {
      stop("animal must be one of 'barnyard', 'bird', 'cat', 'dog', 'horse', 'reptile', or 'smallfurry'")
    }   
  }
  
  if (!is.null(size)) {
    sizes <- c('S', 'M', 'L', 'XL')
    
    if (!size %in% sizes) {
      stop("size parameter must be one of 'S' (small), 'M' (medium), 'L' (large), or 'XL' (extra-large)")
    }
  }

  if (!is.null(sex)) {
    genders <- c('M', 'F')
    
    if (!sex %in% genders) {
      stop("sex parameter must be one of 'M' (male), or 'F' (female)")
    }
  }
  
  if (!is.null(age)) {
    ages <- c('Baby', 'Young', 'Adult', 'Senior')
    
    if (!age %in% ages) {
      stop("age parameter must be one of 'Baby', 'Young', 'Adult', or 'Senior'")
    }
  }
  
}
