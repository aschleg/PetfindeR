context('test breeds method')


test_that('breeds method returns correct information', {
  skip_on_cran()
  pf <- Petfinder(key = Sys.getenv('PETFINDER_KEY'), 
                  secret = Sys.getenv('PETFINDER_SECRET_KEY'))
  
  all_types <- c('dog', 'cat', 'rabbit', 'small-furry', 'horse', 'bird',
                 'scales-fins-other', 'barnyard')
  
  all_breeds <- pf$breeds()
  
  expect_true(length(all_breeds) == 8)
  n <- names(all_breeds)
  expect_equal(tolower(n), all_types)
  
  cat_breeds <- pf$breeds('cat')
  
  expect_true(length(cat_breeds) == 1)
  expect_is(cat_breeds$cat, 'character')
  
  multi_breeds <- pf$breeds(c('cat', 'dog'))
  
  expect_true(length(multi_breeds) == 2)
  expect_equal(c('cat', 'dog'), names(multi_breeds))
})