
# PetfindeR 1.0.0

First release implementing primary functionality for interacting with the Petfinder API. The following table of methods can also be found in the project's README.

| Method                | Petfinder API Method | Description                                                                                        |
|-----------------------|----------------------|----------------------------------------------------------------------------------------------------|
| breed.list()          | breed.list           | Returns the available breeds for the selected animal.                                              |
| pet.find()            | pet.find             | Returns a collection of pet records matching input parameters.                                     |
| pet.get()             | pet.get              | Returns a single record for a pet.                                                                 |
| pet.getRandom()       | pet.getRandom        | Returns a randomly selected pet record. The possible result can be filtered with input parameters. |
| shelter.find()        | shelter.find         | Returns a collection of shelter records matching input parameters.                                 |
| shelter.get()         | shelter.get          | Returns a single shelter record.                                                                   |
| shelter.getPets()     | shelter.getPets      | Returns a collection of pet records for an individual shelter.                                     |
| shelter.listByBreed() | shelter.listByBreed  | Returns a list of shelter IDs listing animals matching the input animal breed.

