# PetfindeR

[![Build Status](https://travis-ci.org/aschleg/PetfindeR.svg?branch=master)](https://travis-ci.org/aschleg/PetfindeR)
[![Build status](https://ci.appveyor.com/api/projects/status/78048x1q7086r0dl?svg=true)](https://ci.appveyor.com/project/aschleg/petfinder)
[![codecov](https://codecov.io/gh/aschleg/PetfindeR/branch/master/graph/badge.svg)](https://codecov.io/gh/aschleg/PetfindeR)
![https://cran.r-project.org/package=PetfindeR](https://www.r-pkg.org/badges/version/PetfindeR)

:cat2: :dog2: :rooster: :rabbit2: :racehorse:

`PetfindeR` wraps the [Petfinder API](https://www.petfinder.com/developers/api-docs) in an easy-to-use, conveninent R package. The `PetfindeR` library also provides handy methods for coercing the returned JSON from the API into usable `data.frame` objects to facilitate data analysis and other tasks. 

## Installation

`PetfindeR` can be installed through the usual means:

~~~ r
install.packages('PetfindeR')
~~~

The package can also be installed with [`devtools`](https://cran.r-project.org/package=devtools) for those wanting the most recent development version.

~~~ r
install.packages('devtools') # if devtools is not already installed
devtools::install_github('aschleg/PetfindeR')
~~~

## Examples and Usage

An account must first be created with [Petfinder](https://www.petfinder.com/developers/) to receive an API and secret key. The API and secret key will be used to grant access to the Petfinder API, which lasts for 3600 seconds, or one hour. After the authentication period ends, you must re-authenticate with the Petfinder API. The following are some quick examples for using `PetfindeR` to get started. More in-depth tutorials for `PetfindeR` and some examples of what can be done with the library, please see the More Examples and Tutorials section below.

### Authenticating with the Petfinder API

Authenticating the connection with the Petfinder API is done at the same time the `Petfinder` class is initialized.

~~~ python
pf = Petfinder(key=key, secret=secret)
~~~


## Documentation

* [PetfindeR PDF Reference Manual](https://CRAN.R-project.org/package=PetfindeR/PetfindeR.pdf)
* [Petfinder API v2.0 documentation](https://www.petfinder.com/developers/v2/docs/)

## Vignettes

Vignettes are long-form documentation that explore more in-depth concepts related to the package. 

* [PetfindeR Introduction Part One](https://CRAN.R-project.org/package=PetfindeR/vignettes/PetfindeR_Introduction_Part_One.html)
* [PetfindeR Introduction Part Two](https://CRAN.R-project.org/package=PetfindeR/vignettes/PetfindeR_Introduction_Part_Two.html)

## About [Petfinder.com](https://www.petfinder.com)

Petfinder.com is one of the largest online, searchable databases for finding a new pet online. The database contains information on over 14,000 animal shelters and adoption organizations across North America with nearly 300,000 animals available for adoption. Not only does this make it a great resource for those looking to adopt their new best friend, but the data and information provided in Petfinder's database makes it ideal for analysis. 