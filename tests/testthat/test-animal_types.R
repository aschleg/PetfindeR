context('test animal_types method')


test_that('animal_types method returns correct information', {
  skip_on_cran()
  pf <- Petfinder(key = Sys.getenv('PETFINDER_KEY'), 
                  secret = Sys.getenv('PETFINDER_SECRET_KEY'))
  
  all_types <- c('dog', 'cat', 'rabbit', 'small & furry', 'horse', 'bird',
                 'scales, fins & other', 'barnyard')
  
  all_ani_types <- pf$animal_types()
  
  n <- names(all_ani_types)
  expect_true(length(all_ani_types) == 8)
  expect_equal(tolower(n), all_types)
  
  cats <- pf$animal_types('cat')
  
  expect_true(length(cats) == 1)
  expect_is(cats$Cat$name, 'character')
  expect_is(cats$Cat$coats, 'character')
  expect_is(cats$Cat$colors, 'character')
  expect_is(cats$Cat$genders, 'character')
  
  multi_types <- pf$animal_types(c('cat', 'dog'))
  
  expect_true(length(multi_types) == 2)
  expect_equal(c('cat', 'dog'), tolower(names(multi_types)))
})