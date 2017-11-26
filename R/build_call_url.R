

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
                 'format' = outputformat,
                 'offset' = offset,
                 'count' = count,
                 'pages' = pages,
                 'id' = id
  )
  
  params <- params[!sapply(params, is.null)]
  return(params)
}


return_json = function(url, params) {
  url <- parse_url(url)
  url$query <- params
  url <- build_url(url)
  
  json_url <- fromJSON(url)
  
  return(json_url)
}