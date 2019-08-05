context('dummy test for method doc functions')

test_that("dummy methods don't do anything", {
  expect_null(breeds('cat'))
  expect_null(animal_types('cat'))
  expect_null(animals())
  expect_null(organizations())
})