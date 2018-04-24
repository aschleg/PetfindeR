context('test call URL build')


httptest::with_mock_api({
  test_that('parameters function returns parameters correctly', {
    param <- parameters(key = Sys.getenv('PETFINDER_KEY'),
                        animal = 'cat', 
                        size = 'M', 
                        location = 'WA', 
                        sex = 'F', 
                        status = 'A')
    
    expect_true(param$key == Sys.getenv('PETFINDER_KEY'))
    expect_true(param$animal == 'cat')
    expect_true(param$size == 'M')
    expect_true(param$location == 'WA')
    expect_true(param$sex == 'F')
    expect_true(param$status == 'A')
  })
  
  test_that('check_inputs function returns errors appropriately', {
    expect_error(check_inputs(animal = 'zebra'), 
                 "animal must be one of 'barnyard', 'bird', 'cat', 'dog', 'horse', 'reptile', or 'smallfurry'")
    
    expect_error(check_inputs(size = 'Ginormous'), 
                 "size parameter must be one of 'S' \\(small\\), 'M' \\(medium\\), 'L' \\(large\\), or 'XL' \\(extra-large\\)")
    
    expect_error(check_inputs(sex = 'U'), 
                 "sex parameter must be one of 'M' \\(male\\), or 'F' \\(female\\)")
    
    expect_error(check_inputs(age = 'Old'), 
                 "age parameter must be one of 'Baby', 'Young', 'Adult', or 'Senior'")
    
  })
})