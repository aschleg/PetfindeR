context('test animals method')


test_that('animals method returns correct information', {
  skip_on_cran()
  pf <- Petfinder(key = Sys.getenv('PETFINDER_KEY'), 
                  secret = Sys.getenv('PETFINDER_SECRET_KEY'))
  
  general_search <- pf$animals()

  expect_is(general_search, 'list')
  expect_is(general_search$page1, 'data.frame')
  
  ids_to_search <- general_search$page1$id[0:3]
  id_search <- pf$animals(animal_id = ids_to_search)
  
  expect_is(id_search, 'list')
  expect_is(id_search[0], 'list')
  expect_true(length(id_search) == 3)
  
  n <- as.integer(names(id_search))
  expect_equal(n, ids_to_search)
  
  wa_search <- pf$animals(location = 'WA', distance = 20, pages = 2)
  
  expect_is(wa_search, 'list')
  expect_is(wa_search$page1, 'data.frame')
  expect_true(nrow(wa_search$page1) == 20)
  
})