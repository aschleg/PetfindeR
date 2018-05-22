## ------------------------------------------------------------------------
library(PetfindeR)

## ------------------------------------------------------------------------
key <- Sys.getenv('PETFINDER_KEY')

## ------------------------------------------------------------------------
pf <- Petfinder(key)

## ---- eval=FALSE---------------------------------------------------------
#  cats <- pf$breed.list('cat')
#  cats

## ---- eval=FALSE---------------------------------------------------------
#  cats <- pf$breed.list('cat', return_df = TRUE)
#  head(cats)

## ---- eval=FALSE---------------------------------------------------------
#  wa_cats <- pf$pet.find('WA', 'cat', sex='F')

## ---- eval=FALSE---------------------------------------------------------
#  wa_cats <- pf$pet.find('WA', 'cat', sex='F', return_df = TRUE)
#  head(wa_cats[,1:10])

## ---- eval=FALSE---------------------------------------------------------
#  pf$pet.getRandom(output = 'full')

## ---- eval=FALSE---------------------------------------------------------
#  random_records <- pf$pet.getRandom(records = 3, output = 'full')

## ---- eval=FALSE---------------------------------------------------------
#  random_records_df <- pf$pet.getRandom(records = 3, output = 'full', return_df = TRUE)
#  random_records_df[,1:10]

## ---- eval=FALSE---------------------------------------------------------
#  pet_get_df <- pf$pet.get(petId = random_records_df$id, return_df = TRUE)
#  pet_get_df[,1:10]

## ---- eval=FALSE---------------------------------------------------------
#  wa_shelters <- pf$shelter.find('98115')
#  head(wa_shelters$petfinder$shelters$shelter)

## ---- eval=FALSE---------------------------------------------------------
#  wa_shelters_df <- pf$shelter.find('98115', return_df = TRUE)
#  head(wa_shelters_df)

## ---- eval=FALSE---------------------------------------------------------
#  safr <- pf$shelter.get('WA40')
#  safr

## ---- eval=FALSE---------------------------------------------------------
#  safr_df <- pf$shelter.get('WA40', return_df = TRUE)
#  safr_df

## ---- eval=FALSE---------------------------------------------------------
#  safr.pets <- pf$shelter.getPets('WA40')
#  head(safr.pets$petfinder$pets$pet)[,1:10]

## ---- eval=FALSE---------------------------------------------------------
#  safr.pets_df <- pf$shelter.getPets('WA40', return_df = TRUE)
#  head(safr.pets_df)[,1:10]

## ---- eval=FALSE---------------------------------------------------------
#  aby_shelters <- pf$shelter.listByBreed('cat', 'Abyssinian')

