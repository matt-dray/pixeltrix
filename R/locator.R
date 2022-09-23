#' Create Pixel Art, Get a Matrix
#'
#' A plotting canvas will be opened with the provided dimensions with a grid of
#' clickable squares. These can be clicked between 'on' and 'off' states, or
#' a number of states provided by the user. Press the ESCAPE key to exit the
#' interactive mode and be returned a matrix with the updated values.
#'
#' @param n_rows Integer. The number of 'pixels' high that the plot should be.
#' @param n_cols Integer. The number of 'pixels' wide that the plot should be.
#' @param n_states Integer. The number of states that a pixel can be. Click a
#'     pixel to cycle through the states. See details.
#' @param grid Logical. Should a boundary line be placed around the pixels to
#'     make them easier to differentiate? Defaults to TRUE.
#'
#' @details The pixel states are in a zero-indexed sequence, so
#'     \code{n_states = 2} results in binary values of 0 and 1, while
#'     \code{n_states = 4} would yield 0, 1, 2 and 3. Clicking a pixel changes
#'     increases its state value by one. Clicking a pixel with the maximum
#'     state value will cycle it back to the lowest state value.
#'
#'     Pixel colours change from lightest to darkest as you click through
#'     their states.
#'
#'     Numeric values are coerced to integers.
#'
#' @return A matrix.
#'
#' @export
#'
#' @examples \dontrun{click_pixels(3, 4, 4, FALSE)}
click_pixels <- function(
    n_rows = 8L,
    n_cols = 16L,
    n_states = 2L,
    grid = TRUE
) {

  if (!is.numeric(n_rows) | !is.numeric(n_cols) | !is.numeric(n_states)) {
    stop("'n_rows', 'n_cols' and 'n_states' must be integer values.")
  }

  if (!is.logical(grid)) {
    stop("'grid' must be TRUE or FALSE.")
  }

  n_rows   <- as.integer(n_rows)
  n_cols   <- as.integer(n_cols)
  n_states <- as.integer(n_states)

  m <- matrix(0, n_rows, n_cols)

  .plot_canvas(m, n_states)

  if (grid) {
    .add_grid(m)
  }

  repeat {

    p <- .locate_on_grid(m)

    if (is.null(p)) {

      break

    } else {

      m <- .update_matrix(m, p, n_states)

      grDevices::dev.off()

      .plot_canvas(m, n_states)

      if (grid) {
        .add_grid(m)
      }

    }

  }

  m

}

.plot_canvas <- function(m, n) {

  graphics::par(mar = rep(1, 4))

  m <- t(m[nrow(m):1, ])

  graphics::image(
    m,
    zlim = c(0, n),
    col = gray.colors(n + 1, 0, 1, rev = TRUE),
    xlab = "", ylab = "",
    axes = FALSE
  )

}

.add_grid <- function(m) {

  x_n <- ncol(m)
  x_unit <- 1 / (x_n - 1)
  x_lines <- seq(0 - x_unit - (x_unit / 2), 1 + x_unit + (x_unit / 2), x_unit)

  y_n <- nrow(m)
  y_unit <- 1 / (y_n - 1)
  y_lines <- seq(0 - y_unit - (y_unit / 2), 1 + y_unit + (y_unit / 2), y_unit)

  abline(v = x_lines)
  abline(h = y_lines)

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

.update_matrix <- function(m, p, n) {

  states <- seq(0L, n - 1L)
  current_state <- m[p$y, p$x]
  next_state <- current_state + 1L

  if (next_state > n - 1L) {
    next_state <- states[1]
  }

  m[p$y, p$x] <- next_state

  return(m)

}
