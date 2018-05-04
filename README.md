# PetfindeR

[![Build Status](https://travis-ci.org/aschleg/PetfindeR.svg?branch=master)](https://travis-ci.org/aschleg/PetfindeR)
[![Build status](https://ci.appveyor.com/api/projects/status/78048x1q7086r0dl?svg=true)](https://ci.appveyor.com/project/aschleg/petfinder)
[![codecov](https://codecov.io/gh/aschleg/PetfindeR/branch/master/graph/badge.svg)](https://codecov.io/gh/aschleg/PetfindeR)

PetfindeR wraps the [Petfinder API](https://www.petfinder.com/developers/api-docs) in an easy-to-use, conveninent R package. The PetfindeR library also provides handy methods for coercing the returned JSON from the API into usable `data.frame` objects to facilitate data analysis and other tasks. 

## Example

After receiving an API key from [Petfinder](https://www.petfinder.com/developers/api-key), usage of `PetfindeR` to extract data from the Petfinder database is straightforward.

~~~
library(PetfindeR)

pf = Petfinder(key) # Initialize the connection with the Petfinder API.
cats = pf$breed.list('cat')
pf$pet.getRandom()
~~~

The above simple example creates an authenticated connection to the Petfinder API and then uses that connection to pull the entire list of cat breeds listed in the Petfinder database. The next line returns a randomly selected pet record.

## Available Methods

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

## Documentation

* [Petfinder API Documentation](https://www.petfinder.com/developers/api-docs#methods)

## About [Petfinder.com](https://www.petfinder.com)

:cat2: :dog2: :rooster: :rabbit2: :racehorse:

Petfinder.com is one of the largest online, searchable databases for finding a new pet online. The database contains information on over 14,000 animal shelters and adoption organizations across North America with nearly 300,000 animals available for adoption. Not only does this make it a great resource for those looking to adopt their new best friend, but the data and information provided in Petfinder's database makes it ideal for analysis. 