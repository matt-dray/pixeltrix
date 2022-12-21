#' Click 'Pixels' in an Interactive Plot
#'
#' Opens an interactive plot with a grid of squares ('pixels') that you can
#' click to cycle through. Returns a matrix 'blueprint' of your image.
#'
#' @param n_rows Integer. The number of pixels high that the plot should be.
#'     Numeric values are coerced to integer.
#' @param n_cols Integer. The number of pixels wide that the plot should be.
#'     Numeric values are coerced to integer.
#' @param n_states Integer. The number of states that a pixel can be cycled
#'     through with successive clicks. Numeric values are coerced to integer.
#'     See details.
#' @param colours Character vector. As many named/hex colours as n_state. Each
#'     click in the interactive plot will cycle a pixel through these colours.
#'     Defaults to NULL, which generates a gradation from white to dark grey.
#'     See details.
#' @param grid Logical. Should a black boundary line be placed around the pixels
#'     to help differentiate between them? Defaults to TRUE.
#'
#' @details Click repeatedly the pixels in the interactive plotting window to
#'     cycle through the provided number of 'states'. The initial state value is
#'     0 and successive clicks increase it by 1, wrapping back to 0 once the
#'     maximum number of states is exceeded. Press the ESCAPE key to exit the
#'     interactive mode.
#'
#' @return A matrix. Values correspond to the state of each pixel, which is
#'     determined by the number of clicks. There are two additional attributes:
#'     'n_states' is the number of pixel state values provided; 'colours' is
#'     a character vector provided by the user (or a gradated set of greys
#'     provided by default when colours' is NULL), which is named according to
#'     the corresponding state value in the output matrix.
#'
#' @export
#'
#' @examples \dontrun{
#'     # Create a 16 x 16 pixel matrix with 3 possible pixel states
#'     my_matrix <- click_pixels(
#'       n_rows   = 16,
#'       n_cols   = 16,
#'       n_states = 3,
#'       colours  = c("blue", "#FF0000", "yellow")
#'     )
#' }
click_pixels <- function(
    n_rows   = 8L,
    n_cols   = 8L,
    n_states = 2L,
    colours  = NULL,
    grid     = TRUE
) {

  if (!is.numeric(c(n_rows, n_cols, n_states))) {
    stop("Arguments 'n_rows', 'n_cols' and 'n_states' must be integer values.")
  }

  if (!is.logical(grid)) {
    stop("Argument 'grid' must be TRUE or FALSE.", call. = FALSE)
  }

  if (!is.null(colours) && (length(colours) != n_states)) {
    stop(
      "Argument 'colours' must be a character vector of length 'n_states'.",
      call. = FALSE
    )
  }

  n_rows   <- as.integer(n_rows)
  n_cols   <- as.integer(n_cols)
  n_states <- as.integer(n_states)

  if (is.null(colours)) {
    get_greys <- grDevices::colorRampPalette(c("white", "grey20"))
    colours   <- get_greys(n_states)  # gradated colours from white to dark grey
  }

  m <- matrix(0L, n_rows, n_cols)

  .plot_canvas(m, n_states, colours)
  if (grid) .add_grid(m)
  m <- .repeat_loop(m, n_states, colours, grid)

  attr(m, "n_states") <- as.integer(n_states)
  attr(m, "colours")  <- setNames(colours, seq(0, n_states - 1))

  m

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
#' @param n_states Integer. The number of states that a pixel can be cycled
#'     through with successive clicks. Numeric values are coerced to integer.
#'     Defaults to NULL, which results in an attempt to find and use the
#'     'n_states' attribute (integer) of the input matrix, 'm'. The attribute is
#'     added by default to matrices created with \code{\link{click_pixels}}
#'     (recommended).
#' @param colours Character vector. As many named/hex colours as n_state. Each
#'     click in the interactive plot will cycle a pixel through these colours.
#'     Defaults to NULL, which results in an attempt to find and use the
#'     'colours' attribute (named character vector) of the input matrix, 'm'.
#'     This attribute is added by default to matrices created with
#'     \code{\link{click_pixels}} (recommended).
#' @param grid Logical. Should a black boundary line be placed around the pixels
#'     to help differentiate between them? Defaults to TRUE.
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
#'     # Create a 3 x 4 pixel matrix with 3 possible states to cycle through
#'     my_matrix <- click_pixels(
#'       n_rows   = 3,
#'       n_cols   = 4,
#'       n_states = 3,
#'       colours  = c("white", "red", "#0000FF")
#'     )
#'
#'.    # Update the original matrix
#'     my_matrix_edited <- edit_pixels(m = my_matrix)
#'
#'     # Update the original matrix with additional state, different colours
#'     my_matrix_augmented <- edit_pixels(
#'       m        = my_matrix,
#'       n_states = 4,  # one more than in the original
#'       colours  = c("bisque3", "orchid", "chartreuse", "olivedrab")
#'     )
#' }
edit_pixels <- function(m, n_states = NULL, colours = NULL, grid = TRUE) {

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

  # Coerce state count to integer if provided
  if (!is.null(n_states)) {
    n_states <- as.integer(n_states)
  }

  # Take n_states from attributes of input matrix, if present
  if (is.null(n_states) & !is.null(attr(m, "n_states"))) {
    n_states <- attr(m, "n_states")
  }

  # Take colours from attributes of input matrix, if present
  if (is.null(colours) & !is.null(attr(m, "colours"))) {
    colours <- attr(m, "colours")
  }

  .plot_canvas(m, n_states, colours)
  if (grid) .add_grid(m)
  m <- .repeat_loop(m, n_states, colours, grid)

  attr(m, "n_states") <- as.integer(n_states)
  attr(m, "colours")  <- setNames(colours, seq(0, n_states - 1))

  m

}
