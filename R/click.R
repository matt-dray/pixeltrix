#' Click 'Pixels' in an Interactive Plot
#'
#' Opens a new interactive plotting canvas with a grid of clickable squares
#' ('pixels').
#'
#' @param n_rows Integer. The number of 'pixels' high that the plot should be.
#'     Numeric values are coerced to integer.
#' @param n_cols Integer. The number of 'pixels' wide that the plot should be.
#'     Numeric values are coerced to integer.
#' @param n_states Integer. The number of states that a pixel can be. Click a
#'     pixel to cycle through the states. Numeric values are coerced to integer.
#'     See details.
#' @param grid Logical. Should a boundary line be placed around the pixels to
#'     make them easier to differentiate? Defaults to TRUE.
#'
#' @details Click the pixels in the plotting window repeatedly to cycle through
#'     a number of 'states'. Successive clicks increase the state value by 1
#'     (wrapping back to 0, the default when the canvas is first plotted) and
#'     make the pixel darker grey in colour. Press the ESCAPE key to exit the
#'     mode and be returned a matrix that contains the state values of each
#'     pixel.
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

  if (!is.numeric(c(n_rows, n_cols, n_states))) {
    stop("Arguments 'n_rows', 'n_cols' and 'n_states' must be integer values.")
  }

  if (!is.logical(grid)) {
    stop("Argument 'grid' must be TRUE or FALSE.")
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
