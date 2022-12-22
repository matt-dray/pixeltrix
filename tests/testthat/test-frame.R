test_that("error occurs when 'n_*' aren't numeric", {

  expect_error(frame_pixels(n_rows   = "x"))
  expect_error(frame_pixels(n_cols   = "x"))
  expect_error(frame_pixels(n_states = "x"))

  expect_error(frame_pixels(n_rows   = mtcars))
  expect_error(frame_pixels(n_cols   = mtcars))
  expect_error(frame_pixels(n_states = mtcars))

  expect_error(frame_pixels(n_rows   = FALSE))
  expect_error(frame_pixels(n_cols   = FALSE))
  expect_error(frame_pixels(n_states = FALSE))

})

test_that("error occurs when 'colours' isn't a character vector", {

  expect_error(frame_pixels(colours = 1))
  expect_error(frame_pixels(colours = mtcars))
  expect_error(frame_pixels(colours = FALSE))

})

test_that("error occurs when 'colours' length doesn't match 'n_states'", {

  expect_error(frame_pixels(n_states = 2, colours = "red"))
  expect_error(frame_pixels(n_states = 1, colours = c("red", "blue")))

})

test_that("error occurs when 'grid' is not logical", {

  expect_error(frame_pixels(grid = 1))
  expect_error(frame_pixels(grid = "x"))
  expect_error(frame_pixels(grid = mtcars))

})
