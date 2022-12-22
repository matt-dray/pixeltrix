test_that("error occurs when 'm' is not a matrix", {

  expect_error(draw_pixels(m = 1))
  expect_error(draw_pixels(m = "x"))
  expect_error(draw_pixels(m = mtcars))
  expect_error(draw_pixels(m = array(1, c(1, 1, 2))))

})

test_that("error occurs when 'colours' length doesn't match 'n_states'", {

  expect_error(
    draw_pixels(
      m = matrix(rep(0:1, 3), 3),
      colours = c("red", "yellow", "blue")
    )
  )

  expect_error(
    draw_pixels(
      m = matrix(rep(0:1, 3), 3),
      colours = "red"
    )
  )

})
