#' Interactive Pixel-Clicking Tool (User-Provided Matrix)
#'
#' Opens an interactive plotting canvas with a grid of clickable squares
#' ('pixels'). Click pixels repeatedly to cycle through a number of 'states'.
#' Successive clicks increase the state value by 1 (wrapping back to 0) and make
#' the pixel a darker colour. Press the ESCAPE key to exit the interactive mode
#' and be returned a matrix that contains the state values of each pixel.
#'
#' @param m A matrix of integers. The maximum value is assumed to be the number
#'     of pixel states desired. Can be overriden by supplying n_states.
#' @param n_states Integer. The number of states that a pixel can be. Click a
#'     pixel to cycle through the states. See details.
#' @param grid Logical. Should a boundary line be placed around the pixels to
#'     make them easier to differentiate? Defaults to TRUE.
#'
#' @details The pixel states are in a zero-indexed sequence, so
#'     \code{n_states = 2} results in binary values of 0 and 1, while
#'     \code{n_states = 4} would yield 0, 1, 2 and 3. Clicking a pixel increases
#'     its state value by 1. Clicking a pixel with the maximum state value
#'     will cycle it back to the lowest state value of 0.
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
#' @examples \dontrun{edit_pixels(m, 3, FALSE)}
edit_pixels <- function(m, n_states = NULL, grid = TRUE) {

  if (!is.matrix(m) | !is.integer(m)) {
    stop("'m' must be a matrix object composed of integers.")
  }

  if (!is.null(n_states)) {
    if (!is.numeric(n_states)) {
      stop("'n_states' must be an integer value or NULL.")
    }
  }

  if (!is.null(n_states) && n_states < max(m)) {
    stop(
      "The number of states, 'n_states', can't be less than ",
      "the maximum value in the provided matrix, 'm'."
    )
  }

  if (!is.logical(grid)) {
    stop("'grid' must be TRUE or FALSE.")
  }

  if (is.null(n_states)) {
    n_states <-  max(m) + 1L
  } else if (is.null(n_states)) {
    n_states <- as.integer(n_states)
  }

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
