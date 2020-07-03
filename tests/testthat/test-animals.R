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
  
  max_search <- pf$animals(location = 'Seattle, WA', distance = 1, pages = NULL)
  expect_is(max_search, 'list')
  expect_is(max_search$page1, 'data.frame')
  
  good_with_filters <- pf$animals(good_with_cats = TRUE, good_with_children = TRUE, good_with_dogs = TRUE)
  expect_true(all(good_with_filters$environment.cats))
  expect_true(all(good_with_filters$environment.children))
  expect_true(all(good_with_filters$environment.dogs))
  
  before_date <- pf$animals(before_date = '2020-06-29')
  expect_true(all(before_date$page1$published_at >= lubridate::format_ISO8601(as.POSIXct('2020-06-29 00:00:00'), usetz = TRUE)))
  
  after_date <- pf$animals(after_date = '2020-06-30 0:0:0')
  expect_true(all(after_date$page1$published_at >= lubridate::format_ISO8601(as.POSIXct('2020-06-30'), usetz = TRUE)))
  
  between_date <- pf$animals(before_date = '2020-06-30', after_date = '2020-06-28')
  expect_true(all(between_date$page1$published_at >= lubridate::format_ISO8601(as.POSIXct('2020-06-28'), usetz = TRUE)))
  
})