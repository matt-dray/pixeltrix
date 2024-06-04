m <- matrix(c(0L, 1L, 1L, 0L), 2, 2)
m <- as_pixeltrix(m)

test_that("coercion to 'pixeltrix' class works", {
  expect_s3_class(m, "pixeltrix")
})

test_that("detection of 'pixeltrix' class works", {
  expect_true(is_pixeltrix(m))
})
