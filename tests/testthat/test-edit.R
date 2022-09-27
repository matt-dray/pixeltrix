test_that("error occurs when 'm' is not a matrix", {

  expect_error(edit_pixels(m = 1))
  expect_error(edit_pixels(m = "x"))
  expect_error(edit_pixels(m = mtcars))
  expect_error(edit_pixels(m = array(1, c(1, 1, 2))))

})

test_that("error occurs when 'n_states' is not an integer", {

  expect_error(edit_pixels(n_states = "x"))
  expect_error(edit_pixels(n_states = mtcars))

})

test_that("error occurs when 'grid' is not logical", {

  expect_error(edit_pixels(grid = 1))
  expect_error(edit_pixels(grid = "x"))
  expect_error(edit_pixels(grid = mtcars))

})
