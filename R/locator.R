#' Create Pixel Art, Get a Matrix
#'
#' A provided matrix will be opened in the plotting window as a grid of
#' clickable squares. These can be clicked between 'on' and 'off' states.
#' Press ESCAPE to exit the interactive mode and be returned a matrix with the
#' updated values.
#'
#' @param m A matrix. Can only contain values of 0 and 1.
#'
#' @return A matrix.
#'
#' @export
#'
#' @examples \dontrun{
#' m <- matrix(sample(c(0, 1), 12, replace = TRUE), nrow = 3, ncol = 4)
#' click_pixels(m)
#' }
click_pixels <- function(m) {

  if (!unique(as.vector(m)) %in% c(0, 1)) {
    stop("The matrix 'm' can only take values of 0 and 1.")
  }

  .plot_grid(m)

  repeat {

    p <- .locate_on_grid(m)

    if (is.null(p)) {

      break

    } else {

      m <- .update_matrix(m, p)
      grDevices::dev.off()
      .plot_grid(m)

    }

  }

  m

}

.plot_grid <- function(m) {

  graphics::par(mar = rep(1, 4))

  m <- t(m[nrow(m):1, ])

  graphics::image(
    m,
    xlab = "", ylab = "",
    axes = FALSE
  )

}

.locate_on_grid <- function(m) {

  x_n <- ncol(m)
  x_unit <- 1 / (x_n - 1)
  x_mids <- seq(0, 1, x_unit)

  y_n <- nrow(m)
  y_unit <- 1 / (y_n - 1)
  y_mids <- seq(0, 1, y_unit)

  p <- graphics::locator(1)

  if (length(p) == 0) {

    return(NULL)

  } else {

    x_diffs <- abs(p$x - x_mids)
    y_diffs <- rev(abs(p$y - y_mids))

    list(
      x = which.min(x_diffs),
      y = which.min(y_diffs)
    )

  }

}

.update_matrix <- function(m, p) {

  val <- m[p$y, p$x]

  if (val == 0) {
    m[p$y, p$x] <- 1
  } else if (val == 1) {
    m[p$y, p$x] <- 0
  }

  return(m)

}
