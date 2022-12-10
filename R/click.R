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
#' @examples \dontrun{
#' # Create a 16 x 16 pixel matrix with 3 possible states to cycle through
#' click_pixels(n_rows = 16, n_cols = 16, n_states = 3, grid = TRUE)
#' }
click_pixels <- function(
    n_rows   = 8L,
    n_cols   = 16L,
    n_states = 2L,
    grid     = TRUE
) {

  if (!is.numeric(c(n_rows, n_cols, n_states))) {
    stop("Arguments 'n_rows', 'n_cols' and 'n_states' must be integer values.")
  }

  if (!is.logical(grid)) {
    stop("Argument 'grid' must be TRUE or FALSE.", call. = FALSE)
  }

  n_rows   <- as.integer(n_rows)
  n_cols   <- as.integer(n_cols)
  n_states <- as.integer(n_states)

  m <- matrix(0L, n_rows, n_cols)

  .plot_canvas(m, n_states)

  if (grid) {
    .add_grid(m)
  }

  message("Click squares in the plot window. Press <Esc> to end.")

  .repeat_loop(m, n_states, grid)

}

#' Edit 'Pixels' in an Interactive Plot
#'
#' Opens an interactive plotting canvas with a grid of clickable squares
#' ('pixels') that represent the cells of a matrix provided by the user,
#' ideally the output from \code{\link{click_pixels}}.
#'
#' @param m A matrix of integers. The maximum value is assumed to be the number
#'     of pixel states desired. Override by supplying a 'n_states' value larger
#'     than the maximum in the matrix.
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
#' @examples \dontrun{
#' # Create a 3 x 4 pixel matrix with 3 possible states to cycle through
#' mat <- click_pixels(n_rows = 3, n_cols = 4, n_states = 3)
#'
#' # Update the original matrix, allow for an extra state
#' mat_udpated <- edit_pixels(m = mat, n_states = 4)
#' }
edit_pixels <- function(m, n_states = NULL, grid = TRUE) {

  if (!is.matrix(m) | !is.integer(m)) {
    stop(
      "Argument 'm' must be a matrix object composed of integers.",
      call. = FALSE
    )
  }

  if (!is.null(n_states)) {
    if (!is.numeric(n_states)) {
      stop(
        "Argument 'n_states' must be an integer value or NULL.",
        call. = FALSE
      )
    }
  }

  if (!is.null(n_states) && n_states < max(m + 1L)) {
    stop(
      "The number of states, 'n_states', can't be less than ",
      "the maximum value in the provided matrix, 'm'.",
      call. = FALSE
    )
  }

  if (!is.logical(grid)) {
    stop("Argument 'grid' must be TRUE or FALSE.", call. = FALSE)
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

  message("Click squares in the plot window. Press <Esc> to end.")

  .repeat_loop(m, n_states, grid)

}
