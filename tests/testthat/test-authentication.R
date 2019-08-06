context('test Petfinder API authentication')


test_that('authentication to Petfinder API works correctly', {
  skip_on_cran()
  pf <- Petfinder(key = Sys.getenv('PETFINDER_KEY'), 
                  secret = Sys.getenv('PETFINDER_SECRET_KEY'))
  
  expect_true(is.character(pf$.__enclos_env__$private$auth))
})
