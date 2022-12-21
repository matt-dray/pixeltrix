test_that("error occurs when 'frames' isn't a list of same-sized matrices", {

  m_test <- matrix(1:6, 2, 3)
  frames_test <- list(m_test, m_test, t(m_test))

  expect_error(gif_pixels(frames = frames_test))

})


test_that("error occurs when 'colours' isn't a character vector", {

  expect_error(gif_pixels(colours = 1))
  expect_error(gif_pixels(colours = mtcars))
  expect_error(gif_pixels(colours = FALSE))

})

test_that("error occurs when 'colours' length exceeds max matrix value", {

  expect_error(
    gif_pixels(
      m = matrix(rep(0:1, 3), 3),
      colours = c("red", "yellow", "blue")
    )
  )

})

test_that("error occurs when 'file' is not a character path to a gif file", {

  expect_error(gif_pixels(file = 1))
  expect_error(gif_pixels(file = "x"))
  expect_error(gif_pixels(file = c("x", "y")))
  expect_error(gif_pixels(file = FALSE))

  expect_error(gif_pixels(file = "test.png"))
  expect_error(gif_pixels(file = "gif"))

})
