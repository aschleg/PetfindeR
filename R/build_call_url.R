

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
                 'results_per_page' = results_per_page,
                 'page' = page
  )
  
  params <- params[!sapply(params, is.null)]
  return(params)
}


check_inputs <- function(animal_types=NULL, size=NULL, sex=NULL, age=NULL, count=NULL, pages=NULL) {
  
  if (!is.null(animal)) {
    animals <- c('dog', 'cat', 'rabbit', 'small-furry', 
                 'horse', 'bird', 'scales-fins-other', 'barnyard')
    
    if (!animal %in% animals) {
      stop(paste0('The following animal type options are valid: ', paste0(animals, collapse = ', ')))
    }
  }
  
  if (!is.null(size)) {
    sizes <- c('small', 'medium', 'large', 'xlarge')
    
    if (!size %in% sizes) {
      stop(paste0('The following animal size options are valid: ', paste0(sizes, collapse = ', ')))
    }
  }

  if (!is.null(sex)) {
    genders <- c('male', 'female', 'unknown')
    
    if (!sex %in% genders) {
      stop(paste0('The following gender options are valid: ', paste0(genders, collapse = ', ')))
    }
  }
  
  if (!is.null(age)) {
    ages <- c('baby', 'young', 'adult', 'senior')
    
    if (!age %in% ages) {
      stop(paste0('The following animal age options are valid: ', paste0(ages, collapse = ', ')))
    }
  }
  
  if (!is.null(coats)) {
    coats <- c('short', 'medium', 'long', 'wire', 'hairless', 'curly')
    
    if (!coats %in% coats) {
      stop(paste0('The following coat options are valid: ', paste0(coats, collapse = ', ')))
    }
  }
  
  if (!is.null(status)) {
  status <- c('adoptable', 'adopted', 'found')
    
    if (!status %in% status) {
      stop(paste0('The following status options are valid: ', paste0(status, collapse = ', ')))
    }
  }
  
  if (!is.null(sort)) {
    sort <- c('recent', '-recent', 'distance', '-distance')
    
    if (!sort %in% sort) {
      stop(paste0('The following sorting options are valid: ', paste0(sort, collapse = ', ')))
    }
  }
}
