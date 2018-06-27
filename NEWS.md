# PetfindeR 1.1.3

No changes to the API for internal functionality have been changed. Versioning updated to 1.1.3 in accordance with CRAN submission policies.

# PetfindeR 1.1.0

* The `pet.find` method now correctly extracts results into a `data.frame` when the parameter `return_df = TRUE`.
* The check for results exceeding 2,000 records for an individual search now only stops when the records are actually above 2,000.
* Methods that have a `count` parameter will now check the input value to make sure it is not above 1,000. The 1,000 record limitation is imposed by Petfinder. More information can be found in [Petfinder's API documentation](https://www.petfinder.com/developers/api-docs#restrictions).
* Methods will now check to make sure that the inputted values for parameters `count` and `pages` will not exceed 2,000 records. Petfinder imposes a limit of 2,000 records per search.

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

