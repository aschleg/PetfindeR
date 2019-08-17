context('test http error checking')


test_that('invalid credentials entered returns appropriate error message', {
  skip_on_cran()
  
  expect_error(Petfinder(key = 'test', secret = Sys.getenv('PETFINDER_SECRET_KEY')))
})


test_that('accessing resource with insufficient access returns appropriate message', {
  skip_on_cran()
  
  pf <- Petfinder(key = Sys.getenv('PETFINDER_KEY'), 
                  secret = Sys.getenv('PETFINDER_SECRET_KEY'))
  
  pf$.__enclos_env__$private$host <- "https://api.petfinder.com/v3/"
  
  expect_error(pf$animal_types())
})