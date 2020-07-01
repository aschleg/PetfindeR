# PetfindeR 2.1.0



# PetfindeR 2.0.0

New major release coinciding with the release of [v2.0 of the Petfinder API](https://www.petfinder.com/developers/)! The legacy version of the Petfinder API, v1.0, will be retired in January 2020, therefore, the `PetfindeR` library has been updated almost from the ground up to be compatible as possible with the new version of the Petfinder API! The new version of the Petfinder API is a huge improvement over the legacy version, with many changes and additions to 
the design of the API itself. 

Below is a summary of all the changes made in the release of `PetfindeR 2.0`. 

* The following methods have been added to `PetfindeR` to make it compatible with v2.0 of the Petfinder API.
  - `animal_types()` is used to getting animal types (or type) available from the Petfinder API. The release of v2.0 of the Petfinder API added several endpoints for accessing animal types in the Petfinder database. This method wraps both Petfinder API endpoints for getting animal types. More information on the animal type endpoints in the Petfinder API can be found in its documentation:
    - [Get Animal Types](https://www.petfinder.com/developers/v2/docs/#get-animal-types)
    - [Get Single Animal Type](https://www.petfinder.com/developers/v2/docs/#get-a-single-animal-type)
 - `breeds()` is the new method for getting available animal breeds from the Petfinder database. The API endpoint     documentation is available on the Petfinder API documentation page.
    - [Get Animal Breeds](https://www.petfinder.com/developers/v2/docs/#get-animal-breeds)
 - `animals()` is the method for extracting animal data available on the Petfinder API and deprecates the 
      `pets()` related methods. The method wraps both the `animals` and `animal/{id}` endpoints of the Petfinder API. The documentation for these endpoints can be 
      found in the Petfinder API documentation:
      - [Get Animal](https://www.petfinder.com/developers/v2/docs/#get-animal)
      - [Get Animals](https://www.petfinder.com/developers/v2/docs/#get-animals)
 - `organizations()` is now the method for extracting animal welfare organization data available on Petfinder 
      and deprecates previous `shelter()` related methods and endpoints. The `organizations()` method wraps both 
      the Petfinder API `organizations` and `organizations/{id}` endpoints. The Petfinder API documentation for 
      these two endpoints can be found below:
      - [Get Organizations](https://www.petfinder.com/developers/v2/docs/#get-organizations)
      - [Get Organization](https://www.petfinder.com/developers/v2/docs/#get-organization)
* The following methods have been removed as they are no longer valid endpoints with the release of v2.0 of the Petfinder API.
  - `pet.getRandom`
  - `shelter.getPets`
  - `shelter.listByBreed`

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

