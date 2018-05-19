## ---- include=FALSE------------------------------------------------------
library(httptest)
library(magrittr)
start_vignette('mocks')

## ------------------------------------------------------------------------
library(PetfindeR)

## ------------------------------------------------------------------------
key <- Sys.getenv('PETFINDER_KEY')

## ------------------------------------------------------------------------
pf <- Petfinder(key)

## ------------------------------------------------------------------------
cats <- pf$breed.list('cat')
cats

## ------------------------------------------------------------------------
cats <- pf$breed.list('cat', return_df = TRUE)
head(cats)

## ------------------------------------------------------------------------
wa_cats <- pf$pet.find('WA', 'cat', sex='F')

## ------------------------------------------------------------------------
wa_cats <- pf$pet.find('WA', 'cat', sex='F', return_df = TRUE)
head(wa_cats[,1:10])

## ------------------------------------------------------------------------
pf$pet.getRandom(output = 'full')

## ------------------------------------------------------------------------
random_records <- pf$pet.getRandom(records = 3, output = 'full')

## ------------------------------------------------------------------------
random_records_df <- pf$pet.getRandom(records = 3, output = 'full', return_df = TRUE)
random_records_df[,1:10]

## ------------------------------------------------------------------------
pet_get_df <- pf$pet.get(petId = random_records_df$id, return_df = TRUE)
pet_get_df[,1:10]

## ------------------------------------------------------------------------
wa_shelters <- pf$shelter.find('98115')
head(wa_shelters$petfinder$shelters$shelter)

## ------------------------------------------------------------------------
wa_shelters_df <- pf$shelter.find('98115', return_df = TRUE)
head(wa_shelters_df)

## ------------------------------------------------------------------------
safr <- pf$shelter.get('WA40')
safr

## ------------------------------------------------------------------------
safr_df <- pf$shelter.get('WA40', return_df = TRUE)
safr_df

## ------------------------------------------------------------------------
safr.pets <- pf$shelter.getPets('WA40')
head(safr.pets$petfinder$pets$pet)[,1:10]

## ------------------------------------------------------------------------
safr.pets_df <- pf$shelter.getPets('WA40', return_df = TRUE)
head(safr.pets_df)[,1:10]

## ------------------------------------------------------------------------
aby_shelters <- pf$shelter.listByBreed('cat', 'Abyssinian')

## ---- include=FALSE------------------------------------------------------
end_vignette()

