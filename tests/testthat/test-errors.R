context('test method error checking')

test_that('invalid parameters and other errors return appropriate responses', {
  skip_on_cran()
  
  pf <- Petfinder(key = Sys.getenv('PETFINDER_KEY'), 
                  secret = Sys.getenv('PETFINDER_SECRET_KEY'))
  
  # Animal Types
  
  expect_error(pf$animal_types(types = 'zebra'))
  expect_error(pf$animal_types(types = 1))
  
  # Breeds
  
  expect_error(pf$breeds(types = 'zebra'))
  expect_error(pf$breeds(types = 1))
  
  # Animals & Organizations
  
  expect_error(pf$animals(animal_type = 'zebra'))
  expect_error(pf$animals(size = 'mega'))
  expect_error(pf$animals(gender = 'test'))
  expect_error(pf$animals(age = 'cutebaby'))
  expect_error(pf$animals(coat = 'softandfluffy'))
  expect_error(pf$animals(status = 'blank'))
  expect_error(pf$animals(sort = 'none'))
  expect_error(pf$animals(results_per_page = 1000))
  
  expect_error(pf$organizations(distance = 1000))
  expect_error(pf$organizations(country = 'MX'))
  
})