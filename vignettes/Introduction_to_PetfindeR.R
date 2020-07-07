## ---- eval=FALSE--------------------------------------------------------------
#  key <- Sys.getenv('PETFINDER_KEY')
#  secret <- Sys.getenv('PETFINDER_SECRET_KEY')

## ---- eval=FALSE--------------------------------------------------------------
#  install.packages('PetfindeR')

## ---- eval=FALSE--------------------------------------------------------------
#  install.packages('devtools') # if devtools is not already installed
#  devtools::install_github('aschleg/PetfindeR')

## ---- eval=FALSE--------------------------------------------------------------
#  library(PetfindeR)

## ---- eval=FALSE--------------------------------------------------------------
#  pf = Petfinder(key = key, secret = secret)

## ---- eval=FALSE--------------------------------------------------------------
#  animal_types = pf$animal_types()

## ---- eval=FALSE--------------------------------------------------------------
#  names(animal_types)

## ---- eval=FALSE--------------------------------------------------------------
#  print(animal_types$Cat$coats)
#  print(animal_types$Cat$colors)

## ---- eval=FALSE--------------------------------------------------------------
#  cats = pf$animal_types('cat')

## ---- eval=FALSE--------------------------------------------------------------
#  print(cats$Cat$coats)
#  print(cats$Cat$colors)

## ---- eval=FALSE--------------------------------------------------------------
#  cat_dog <- pf$animal_types(c('cat', 'dog'))
#  print(cat_dog$Dog$coats)
#  print(cat_dog$Cat$coats)

## ---- eval=FALSE--------------------------------------------------------------
#  all_breeds <- pf$breeds()

## ---- eval=FALSE--------------------------------------------------------------
#  for (breed in 1:length(all_breeds)) {
#    print(names(all_breeds[breed]))
#    print(all_breeds[breed][0:3])
#  }

## ---- eval=FALSE--------------------------------------------------------------
#  cat_rabbit = pf$breeds(c('cat', 'rabbit'))
#  
#  for (breed in 1:length(cat_rabbit)) {
#    print(names(all_breeds[breed]))
#    print(all_breeds[breed][0:3])
#  }

## ---- eval=FALSE--------------------------------------------------------------
#  cats = pf$animals(animal_type = 'cat', gender = 'female', status = 'adoptable', location = 'Seattle, WA', distance = 10, results_per_page = 50, pages = 2)

## ---- eval=FALSE--------------------------------------------------------------
#  cat_ids = pf$animals(animal_id = c(animal_id1, animal_id2))

## ---- eval=FALSE--------------------------------------------------------------
#  wa_orgs = pf$organizations(location = 'Seattle, WA', distance = 50, sort = 'distance', pages = 4, results_per_page = 100)

## ---- eval=FALSE--------------------------------------------------------------
#  wa_some_orgs = pf$organizations(organization_id = wa_orgs$page1$id[0:3])

