test_that("error occurs when n_* aren't integers", {

  expect_error(click_pixels(n_rows = "x"))
  expect_error(click_pixels(n_cols = "x"))
  expect_error(click_pixels(n_states = "x"))

  expect_error(click_pixels(n_rows = mtcars))
  expect_error(click_pixels(n_cols = mtcars))
  expect_error(click_pixels(n_states = mtcars))

})

test_that("error occurs when 'grid' is not logical", {

  expect_error(click_pixels(grid = 1))
  expect_error(click_pixels(grid = "x"))
  expect_error(click_pixels(grid = mtcars))

})
