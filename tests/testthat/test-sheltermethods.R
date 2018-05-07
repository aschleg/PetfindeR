context('test shelter methods')


httptest::with_mock_api({
  test_that('shelter.get method returns data appropriately', { 
    skip_on_cran()
    pf <- Petfinder(Sys.getenv('PETFINDER_KEY'))
    
    wa <- pf$shelter.get('WA40')
    wa_df <- shelter_records_to_df(wa$petfinder$shelter)
    
    shelter2 <- pf$shelter.get(shelterId = c('WA40', 'WA401'))
    shelter2_df <- pf$shelter.get(shelterId = c('WA40', 'WA401'), return_df = TRUE)
    
    expect_true(is.list(shelter2))
    expect_true(is.list(shelter2[1]))
    expect_true(is.list(shelter2[2]))
    
    expect_true(is.list(wa))
    expect_true(is.data.frame(wa_df))
    expect_true(nrow(wa_df) == 1)
    
    expect_true(is.data.frame(shelter2_df))
    expect_true(nrow(shelter2_df) == 2)
    
  })
  
  
  test_that('shelter.find method returns data appropriately', {
    skip_on_cran()
    pf <- Petfinder(Sys.getenv('PETFINDER_KEY'))
    
    wa <- pf$shelter.find('WA')
    wa_df <- pf$shelter.find('WA', return_df = TRUE)
    wa_df2 <- pf$shelter.find('WA', pages = 2, return_df = TRUE)
    
    
    expect_true(is.list(wa))
    expect_true(nrow(wa$petfinder$shelters$shelter) == 25)
    
    expect_true(is.data.frame(wa_df))
    expect_true(nrow(wa_df) == 25)
    
    expect_true(is.data.frame(wa_df2))
    expect_true(nrow(wa_df2) == 50)
    
  })
  
  test_that('shelter.getPets returns data appropriately', {
    skip_on_cran()
    pf <- Petfinder(Sys.getenv('PETFINDER_KEY'))
    
    wa_pets <- pf$shelter.getPets(shelterId = 'WA40')
    wa_pets2 <- pf$shelter.getPets(shelterId = 'WA40', return_df = TRUE)
    wa_pets3 <- pf$shelter.getPets(shelterId = 'WA40', return_df = TRUE, pages = 2)
    
    expect_true(is.list(wa_pets))
    expect_true(is.data.frame(wa_pets2))
    expect_true(is.data.frame(wa_pets3))
  })
})