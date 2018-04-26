context('test methods to coerce JSON to data.frame')

httptest::with_mock_api({
  test_that('pet JSON results to data.frame works properly', {
    pf <- Petfinder(Sys.getenv('PETFINDER_KEY'))
    
    pet <- pf$pet.get(pf$pet.getRandom(return_df = TRUE)$id)
    #pet_df <- pet_record(pet$petfinder$pet)
    
    pet_find <- pf$pet.find(location = 'WA')
    pet_find_df <- pet_records_df(pet_find)
    
    expect_true(is.list(pet))
    expect_true(is.data.frame(pet_df))
    expect_true(nrow(pet_df) == 1)
    
    expect_true(is.data.frame(pet_find_df))
    expect_true(nrow(pet_find_df) == 25)
  })
  
  test_that('shelter JSON results coercion to data.frame works correctly', {
    pf <- Petfinder(Sys.getenv('PETFINDER_KEY'))
    
    shelter <- pf$shelter.find(location = 'WA')
    shelter_df <- shelter_records_to_df(shelter$petfinder$shelters)
    
    expect_true(is.list(shelter))
    expect_true(is.data.frame(shelter_df))
    expect_true(dim(shelter_df)[1] == 25)
    
    shelter1 <- pf$shelter.find(location = 'WA', count = 1)
    shelter_df1 <- shelter_records_to_df(shelter$petfinder$shelters$shelter)
    
    expect_true(is.data.frame(shelter_df1))
    expect_true(dim(shelter_df1)[1] == 1)
  })
})