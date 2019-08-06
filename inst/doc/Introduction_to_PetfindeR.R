## ------------------------------------------------------------------------
key <- Sys.getenv('PETFINDER_KEY')
secret <- Sys.getenv('PETFINDER_SECRET_KEY')

## ---- eval=FALSE---------------------------------------------------------
#  install.packages('PetfindeR')

## ---- eval=FALSE---------------------------------------------------------
#  install.packages('devtools') # if devtools is not already installed
#  devtools::install_github('aschleg/PetfindeR')

## ------------------------------------------------------------------------
library(PetfindeR)

## ------------------------------------------------------------------------
pf = Petfinder(key = key, secret = secret)

## ------------------------------------------------------------------------
animal_types = pf$animal_types()

## ------------------------------------------------------------------------
names(animal_types)

## ------------------------------------------------------------------------
print(animal_types$Cat$coats)
print(animal_types$Cat$colors)

## ------------------------------------------------------------------------
cats = pf$animal_types('cat')

## ------------------------------------------------------------------------
print(cats$Cat$coats)
print(cats$Cat$colors)

## ------------------------------------------------------------------------
cat_dog <- pf$animal_types(c('cat', 'dog'))
print(cat_dog$Dog$coats)
print(cat_dog$Cat$coats)

## ------------------------------------------------------------------------
all_breeds <- pf$breeds()

## ------------------------------------------------------------------------

for (breed in 1:length(all_breeds)) {
  print(names(all_breeds[breed]))
  print(all_breeds[breed][[1]][0:3])
}

## ------------------------------------------------------------------------
cat_rabbit = pf$breeds(c('cat', 'rabbit'))

for (breed in 1:length(cat_rabbit)) {
  print(names(all_breeds[breed]))
  print(all_breeds[breed][[1]][0:3])
}

## ------------------------------------------------------------------------
cats = pf$animals(animal_type = 'cat', gender = 'female', status = 'adoptable', 
                  location = 'Seattle, WA', distance = 10, results_per_page = 50, pages = 2)

## ------------------------------------------------------------------------
cats_wa_all_results = pf$animals(animal_type='cat', gender='female', status='adoptable', 
                                 location='Seattle, WA', distance=10, pages=NULL)

## ---- eval=FALSE---------------------------------------------------------
#  cat_ids = pf$animals(animal_id = c(animal_id1, animal_id2))

## ------------------------------------------------------------------------
wa_orgs = pf$organizations(location = 'Seattle, WA', distance = 50, sort = 'distance', pages = NULL)

## ------------------------------------------------------------------------
wa_some_orgs = pf$organizations(organization_id = wa_orgs$page1$id[0:3])

