context('test pet methods')


httptest::with_mock_api({
  test_that('breed.list returns correct information', {
    pf <- Petfinder(Sys.getenv('PETFINDER_KEY'))
    
    cats <- pf$breed.list('cat', return_df = TRUE)
    cat = pf$breed.list('cat', return_df = FALSE)
    dogs <- pf$breed.list('dog', return_df = TRUE)
    
    expect_identical(names(cats), 'cat.breeds')
    expect_identical(names(dogs), 'dog.breeds')
    
    expect_true(is.data.frame(cats))
    expect_true(is.data.frame(dogs))
    
    expect_error(pf$breed.list('zebra'), 
                 "animal must be one of 'barnyard', 'bird', 'cat', 'dog', 'horse', 'reptile', or 'smallfurry'")
    
    expect_true(is.list(cat))
    expect_true(is.data.frame(cat$petfinder$breeds$breed))
    
  })
  
  
  test_that('pet.getRandom returns data consistently', {
    pf <- Petfinder(Sys.getenv('PETFINDER_KEY'))
    
    ran_pet_short <- pf$pet.getRandom(return_df = TRUE)
    
    expect_true(is.data.frame(ran_pet_short))
    expect_true(dim(ran_pet_short)[1] == 1)
    expect_true(dim(ran_pet_short)[2] == 1)
    
    expect_error(pf$pet.getRandom(animal = 'zebra', return_df = TRUE), 
                 "animal must be one of 'barnyard', 'bird', 'cat', 'dog', 'horse', 'reptile', or 'smallfurry'")
    
    ran_pet <- pf$pet.getRandom(output = 'full', return_df = TRUE, records = 5)
    expect_true(is.data.frame(ran_pet))
    expect_true(dim(ran_pet)[1] == 5)
    
    ran_pet_short_nodf <- pf$pet.getRandom()
    expect_true(is.list(ran_pet_short_nodf))
    
  })
  
  
  test_that('pet.get returns data consistently', {
    pf <- Petfinder(Sys.getenv('PETFINDER_KEY'))
    
    pg <- pf$pet.get(pf$pet.getRandom(return_df = TRUE)$id)

    #pg_df <- pf$pet.get(pf$pet.getRandom(return_df = TRUE)$id, return_df = TRUE)
    
    expect_true(is.list(pg))
    #expect_true(is.data.frame(pg_df))
    
  })
  
  
  test_that('pet.find returns data consistently', {
    pf <- Petfinder(Sys.getenv('PETFINDER_KEY'))
    
    petf <- pf$pet.find(location = 'WA')
    
    expect_true(is.list(petf))
    
    
    expect_error(pf$pet.find(location = 'WA', animal = 'zebra'), 
                 "animal must be one of 'barnyard', 'bird', 'cat', 'dog', 'horse', 'reptile', or 'smallfurry'")
    expect_error(pf$pet.find(location = 'WA', size = 'Ginormous'), 
                 "size parameter must be one of 'S' \\(small\\), 'M' \\(medium\\), 'L' \\(large\\), or 'XL' \\(extra-large\\)")
    expect_error(pf$pet.find(location = 'WA', sex = 'U'), 
                 "sex parameter must be one of 'M' \\(male\\), or 'F' \\(female\\)")
    expect_error(pf$pet.find(location = 'WA', age = 'Old'), 
                 "age parameter must be one of 'Baby', 'Young', 'Adult', or 'Senior'")
  })
})