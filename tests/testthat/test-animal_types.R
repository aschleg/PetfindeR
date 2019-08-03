context('test animal_types method')


httptest::with_mock_api({
  test_that('animal_types returns correct information', {
    skip_on_cran()
    pf <- Petfinder(key = Sys.getenv('PETFINDER_KEY'), 
                    secret = Sys.getenv('PETFINDER_SECRET'))
  })
})