# PetfindeR

[![Build Status](https://travis-ci.org/aschleg/PetfindeR.svg?branch=master)](https://travis-ci.org/aschleg/PetfindeR)
[![Build status](https://ci.appveyor.com/api/projects/status/78048x1q7086r0dl?svg=true)](https://ci.appveyor.com/project/aschleg/petfinder)
[![codecov](https://codecov.io/gh/aschleg/PetfindeR/branch/master/graph/badge.svg)](https://codecov.io/gh/aschleg/PetfindeR)

:cat2: :dog2: :rooster: :rabbit2: :racehorse:

`PetfindeR` wraps the [Petfinder API](https://www.petfinder.com/developers/api-docs) in an easy-to-use, conveninent R package. The `PetfindeR` library also provides handy methods for coercing the returned JSON from the API into usable `data.frame` objects to facilitate data analysis and other tasks. 

## Examples and Usage

After receiving an API key from [Petfinder](https://www.petfinder.com/developers/api-key), usage of `PetfindeR` to extract data from the Petfinder database is straightforward. Below, we demonstrate some examples on authenticating with the Petfinder API and extracting data using the available API methods.

#### Authenticating

`PetfindeR` is built using [`R6 Classes`](https://cran.r-project.org/web/packages/R6/index.html), therefore authenticating with the Petfinder API only requires creating an object to store the authentication with a given API key as in the example below.

~~~ r
library(PetfindeR)
pf = Petfinder(key) # Initialize the connection with the Petfinder API.
~~~

#### Get animal breeds currently listed on Petfinder

With the authenticated object `pf` created above, we can use it to extract data from the Petfinder API. To see the available breeds of a particular animal, we can use the `breed.list` method.

~~~ r
cats <- pf$breed.list('cat')
~~~

Most methods in the `PetfindeR` package can also be set to return a `data.frame` instead of the raw JSON from the API by setting the parameter `return_df = TRUE`.

~~~ r
cats.df <- pf$breed.list('cat', return_df = TRUE)
~~~

#### Finding pets listed on Petfinder

The `pet.find` method returns data on the currently available animals at animal shelters in the specified location. The method requires a location to be passed, which can be as granular as a zip code or as broad as a country in North America. The default amount of records returned is 25, which can be increased up to 1,000 by adjusting the `count` parameter. Here we find 100 available female cats listed on the Petfinder website within the Seattle area.

~~~ r
sea.female.cats <- pf$pet.find(location = 'Seattle', animal = 'cat', sex = 'female', count = 100)

# The `pet.find` method can also be set to return a `data.frame` for easier analysis.
sea.female.cats <- pf$pet.find(location = 'Seattle', animal = 'cat', sex = 'female', count = 100, return_df = TRUE)
~~~

## Available Methods

The following table lists the methods for interacting with the Petfinder API.

| Method                | Petfinder API Method | Description                                                                                        |
|-----------------------|----------------------|----------------------------------------------------------------------------------------------------|
| breed.list()          | breed.list           | Returns the available breeds for the selected animal.                                              |
| pet.find()            | pet.find             | Returns a collection of pet records matching input parameters.                                     |
| pet.get()             | pet.get              | Returns a single record for a pet.                                                                 |
| pet.getRandom()       | pet.getRandom        | Returns a randomly selected pet record. The possible result can be filtered with input parameters. |
| shelter.find()        | shelter.find         | Returns a collection of shelter records matching input parameters.                                 |
| shelter.get()         | shelter.get          | Returns a single shelter record.                                                                   |
| shelter.getPets()     | shelter.getPets      | Returns a collection of pet records for an individual shelter.                                     |
| shelter.listByBreed() | shelter.listByBreed  | Returns a list of shelter IDs listing animals matching the input animal breed.                     |

Further information on the methods available in the Petfinder API can be found by checking out [Petfinder's API method documentation](https://www.petfinder.com/developers/api-docs#methods)

## Documentation

* [Petfinder's documentation on its API](https://www.petfinder.com/developers/api-docs)

## About [Petfinder.com](https://www.petfinder.com)

Petfinder.com is one of the largest online, searchable databases for finding a new pet online. The database contains information on over 14,000 animal shelters and adoption organizations across North America with nearly 300,000 animals available for adoption. Not only does this make it a great resource for those looking to adopt their new best friend, but the data and information provided in Petfinder's database makes it ideal for analysis. 