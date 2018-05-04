context('dummy test for method doc functions')

test_that("dummy methods don't do anything", {
  expect_null(breed.list('cat'))
  expect_null(pet.find('WA'))
  expect_null(pet.get('id'))
  expect_null(pet.getRandom())
  
  expect_null(shelter.find('WA'))
  expect_null(shelter.get('WA40'))
  expect_null(shelter.getPets('WA40'))
  expect_null(shelter.listByBreed('cat', 'Domestic Short Hair'))
})