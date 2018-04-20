context('test breed list')

httptest::with_mock_api({
  test_that('breed.list returns list of breeds', {
    pf <- Petfinder(Sys.getenv('PETFINDER_KEY'))
    cats <- pf$breed.list('cat')
    expect_identical(names(cats), 'cat.breeds')
    
    dogs <- pf$breed.list('dog')
    expect_identical(names(dogs), 'dog.breeds')
    
    expect_true(is.data.frame(cats))
    expect_true(is.data.frame(dogs))
  })
})

