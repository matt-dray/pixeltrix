#' Interactive Pixel-Clicking Tool (New Canvas)
#'
#' Opens an interactive plotting canvas with a grid of clickable squares
#' ('pixels'). The canvas is 'blank' in that all the values are set initially
#' to a 'state' of 0. Click pixels repeatedly to cycle through a number of
#' 'states'. Successive clicks increase the state value by 1 (wrapping back to
#' 0) and make the pixel a darker colour. Press the ESCAPE key to exit the
#' interactive mode and be returned a matrix that contains the state values of
#' each pixel.
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
#'     \code{n_states = 4} would yield 0, 1, 2 and 3. Clicking a pixel increases
#'     its state value by 1. Clicking a pixel with the maximum state value
#'     will cycle it back to the lowest state value of 0.
#'
#'     Pixel colours change from lightest to darkest as you click through
#'     their states.
#'
#'     Numeric values provided to 'n_rows', 'n_cols' and 'n_states' are coerced
#'     to integers.
#'
#' @return A matrix.
#'
#' @export
#'
#' @examples \dontrun{click_pixels(3, 4, 4, TRUE)}
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

  m <- matrix(0L, n_rows, n_cols)

  .plot_canvas(m, n_states)

  if (grid) {
    .add_grid(m)
  }

  .repeat_loop(m, n_states, grid)

}
