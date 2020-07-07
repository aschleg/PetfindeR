# PetfindeR

[![Build Status](https://travis-ci.org/aschleg/PetfindeR.svg?branch=master)](https://travis-ci.org/aschleg/PetfindeR)
[![Build status](https://ci.appveyor.com/api/projects/status/78048x1q7086r0dl?svg=true)](https://ci.appveyor.com/project/aschleg/petfinder)
[![codecov](https://codecov.io/gh/aschleg/PetfindeR/branch/master/graph/badge.svg)](https://codecov.io/gh/aschleg/PetfindeR)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/5424a91e87e042b083707a568e890c33)](https://www.codacy.com/manual/aschleg/PetfindeR?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=aschleg/PetfindeR&amp;utm_campaign=Badge_Grade)
![CRAN checks](https://cranchecks.info/badges/summary/badger)](https://cran.r-project.org/web/checks/check_results_badger.html)
![https://cran.r-project.org/package=PetfindeR](https://www.r-pkg.org/badges/version/PetfindeR)

:cat2: :dog2: :rooster: :rabbit2: :racehorse:

`PetfindeR` wraps the [Petfinder API](https://www.petfinder.com/developers/api-docs) in an easy-to-use, conveninent R package. The `PetfindeR` library also provides handy methods for coercing the returned JSON from the API into usable `data.frame` objects to facilitate data analysis and other tasks. 

## Installation

`PetfindeR` can also be installed from CRAN using `install.packages()`: 

~~~ r
install.packages('PetfindeR')
~~~

`Petfinder` can also be installed with [`devtools`](https://cran.r-project.org/package=devtools) to get the most recent production version. 

~~~ r
install.packages('devtools') # if devtools is not already installed
devtools::install_github('aschleg/PetfindeR')
~~~

Please note the version on CRAN may be behind the most recent version on GitHub. I apologize for any confusion or inconvenience; however, submitting the package to CRAN can often be delayed due to reviews and other submission steps.

## Examples and Usage

An account must first be created with [Petfinder](https://www.petfinder.com/developers/) to receive an API and secret key. The API and secret key will be used to grant access to the Petfinder API, which lasts for 3600 seconds, or one hour. After the authentication period ends, you must re-authenticate with the Petfinder API. The following are some quick examples for using `PetfindeR` to get started. More in-depth tutorials for `PetfindeR` and some examples of what can be done with the library, please see the More Examples and Tutorials section below.

### Authenticating with the Petfinder API

Authenticating the connection with the Petfinder API is done at the same time the `Petfinder` class is initialized.

~~~ r
pf = Petfinder(key=key, secret=secret)
~~~

### Finding animal types

~~~ r
# All animal types and their relevant data.
all_types = pf$animal_types()

# Returning data for a single animal type
dogs = pf$animal_types('dog')

# Getting multiple animal types at once
cat_dog_rabbit_types = pf$animal_types(c('cat', 'dog', 'rabbit'))
~~~

### Getting animal breeds for available animal types

~~~ r
cat_breeds = pf$breeds('cat')
dog_breeds = pf$breeds('dog')

# All available breeds or multiple breeds can also be returned.

all_breeds = pf$breeds()
cat_dog_rabbit = pf$breeds(types=c('cat', 'dog', 'rabbit'))
~~~

### Finding available animals on Petfinder

The `animals()` method returns animals based on specified criteria that are listed in the Petfinder database. Specific 
animals can be searched using the `animal_id` parameter, or a search of the database can be performed by entering 
the desired search criteria.

~~~ r
# Getting first 20 results without any search criteria
animals = pf$animals()

cats = pf$animals(animal_type = 'cat', gender = 'female', status = 'adoptable', 
                  location = 'Seattle, WA', distance = 10, results_per_page = 50, pages = 2)
~~~

### Getting animal welfare organizations in the Petfinder database 

Similar to the `animals()` method described above, the `organizations()` method returns data on animal welfare 
organizations listed in the Petfinder database based on specific criteria, if any. In addition to a general search 
of animal welfare organizations, specific organizational data can be extracted by supplying the `organizations()` 
method with organization IDs.

~~~ r
# Return the first 1,000 animal welfare organizations

organizations = pf$organizations(results_per_page = 100, pages = 10)

# Get organizations in the state of Washington

wa_organizations = pf$organizations(state='WA')
~~~

## Documentation

* [Petfinder API v2.0 documentation](https://www.petfinder.com/developers/v2/docs/)

## Vignettes

Vignettes are long-form documentation that explore more in-depth concepts related to the package. 

* [Introduction to PetfindeR](https://cran.r-project.org/web/packages/PetfindeR/vignettes/Introduction_to_PetfindeR.html)

## About [Petfinder.com](https://www.petfinder.com)

Petfinder.com is one of the largest online, searchable databases for finding a new pet online. The database contains information on over 14,000 animal shelters and adoption organizations across North America with nearly 300,000 animals available for adoption. Not only does this make it a great resource for those looking to adopt their new best friend, but the data and information provided in Petfinder's database makes it ideal for analysis. 