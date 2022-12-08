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
#' @examples \dontrun{edit_pixels(m, 3, FALSE)}
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
