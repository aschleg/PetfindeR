context('test organizations method')


test_that('organizations method returns correct information', {
  skip_on_cran()
  pf <- Petfinder(key = Sys.getenv('PETFINDER_KEY'), 
                  secret = Sys.getenv('PETFINDER_SECRET_KEY'))
  
  general_org_search <- pf$organizations()
  
  expect_is(general_org_search, 'list')
  expect_is(general_org_search$page1, 'data.frame')
  expect_true(nrow(general_org_search$page1) == 20)
  expect_true(length(general_org_search) == 1)
  
  ids_to_search <- general_org_search$page1$id[0:3]
  org_search <- pf$organizations(organization_id = ids_to_search)
  
  n <- names(org_search)
  expect_equal(n, ids_to_search)
  
})
