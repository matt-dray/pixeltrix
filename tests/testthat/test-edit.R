test_that("error occurs when 'm' is not a matrix", {

  expect_error(edit_pixels(m = 1))
  expect_error(edit_pixels(m = "x"))
  expect_error(edit_pixels(m = mtcars))
  expect_error(edit_pixels(m = array(1, c(1, 1, 2))))

})

test_that("error occurs when 'n_states' is not numeric", {

  expect_error(edit_pixels(n_states = "x"))
  expect_error(edit_pixels(n_states = mtcars))
  expect_error(edit_pixels(n_states = FALSE))

})

test_that("error occurs when 'colours' isn't a character vector", {

  expect_error(edit_pixels(colours = 1))
  expect_error(edit_pixels(colours = mtcars))
  expect_error(edit_pixels(colours = FALSE))

})

test_that("error occurs when 'n_states' is lower than max matrix value", {

  m_test <- matrix(rep(0:2, 3), 3)
  expect_error(edit_pixels(m = m_test, n_states = 1))

})

test_that("error occurs when 'colours' length doesn't match 'n_states'", {

  expect_error(
    edit_pixels(
      m = matrix(rep(0:1, 3), 3),
      colours = c("red", "yellow", "blue")
    )
  )

  expect_error(
    edit_pixels(
      m = matrix(rep(0:1, 3), 3),
      colours = "red"
    )
  )

})

test_that("error occurs when 'grid' is not logical", {

  expect_error(edit_pixels(grid = 1))
  expect_error(edit_pixels(grid = "x"))
  expect_error(edit_pixels(grid = mtcars))

})
