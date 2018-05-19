## ---- include=FALSE------------------------------------------------------
library(httptest)
start_vignette('mocks')

## ------------------------------------------------------------------------
library(PetfindeR)
key <- Sys.getenv('PETFINDER_KEY')
pf <- Petfinder(key)

## ---- eval=FALSE---------------------------------------------------------
#  paged <- pf$pet.find(location = 'WA', count = 500, pages = 4, return_df = TRUE)
#  paged2 <- pf$pet.find(location = 'WA', count = 1000, pages = 2, return_df = TRUE) # Returns the same as above

## ---- error=TRUE---------------------------------------------------------
count.too.high <- pf$pet.find(location = 'WA', count = 1001, return_df = TRUE)

## ---- error=TRUE---------------------------------------------------------
max.record.exceeded <- pf$pet.find(location = 'WA', count = 500, pages = 5, return_df = TRUE)

## ---- eval=FALSE---------------------------------------------------------
#  no.offset <- pf$pet.find(location = 'WA', count = 50, return_df = TRUE) # Get the first 50 results
#  offsetted <- pf$pet.find(location = 'WA', offset = 50, count = 50, return_df = TRUE) # Skip the first 25 results and get the next 50

## ---- eval=FALSE---------------------------------------------------------
#  paged <- pf$pet.find(location = 'WA', pages = 2, count = 50, return_df = TRUE)
#  raw_count <- pf$pet.find(location = 'WA', count = 100, return_df = TRUE)

## ---- include=FALSE------------------------------------------------------
end_vignette()

