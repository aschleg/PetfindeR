# PetfindeR

[![Build Status](https://travis-ci.org/aschleg/PetfindeR.svg?branch=master)](https://travis-ci.org/aschleg/PetfindeR)

PetfindeR wraps the [Petfinder API](https://www.petfinder.com/developers/api-docs) in an easy-to-use, conveninent R package.

## Example

After receiving an API key from [Petfinder](https://www.petfinder.com/developers/api-key), usage of `PetfindeR` to extract data from the Petfinder database is straightforward.

~~~
library(PetfindeR)

pf = Petfinder(key) # Initialize the connection with the Petfinder API.
cats = pf$breed.list('cat')
pf$pet.getRandom()
~~~

The above simple example creates an authenticated connection to the Petfinder API and then uses that connection to
pull the entire list of cat breeds listed in the Petfinder database. The next line returns a randomly selected
pet record.

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
