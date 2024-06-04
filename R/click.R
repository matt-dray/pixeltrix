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
#' @param colours Character vector. As many named/hex colours as 'n_state'. Each
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
#' @details If your editor opens a separate graphics window (i.e. not RStudio),
#'     each click may result in a brief flash as the image refreshes, while a
#'     resized window may return to its original dimensions. You may also hear a
#'     bell sound on click, which you can disable by setting
#'     `options(locatorBell = FALSE)`.
#'
#' @return A 'pixeltrix'-class matrix. The zero-indexed values correspond to the
#'     state of each pixel, which is determined by the number of clicks a user
#'     gave each pixel. Has a named character-vector attribute, 'colours', which
#'     maps the matrix values to hex colours provided by the user (or a gradated
#'     set of greys provided by default when the 'colours' argument is NULL).
#'
#' @export
#'
#' @examples \dontrun{
#' # Create a 16 x 16 pixel matrix with 3 possible pixel states
#' my_matrix <- click_pixels(
#'   n_rows   = 16L,
#'   n_cols   = 16L,
#'   n_states = 3L,
#'   colours  = c("blue", "#FF0000", "yellow")
#' )
#' }
click_pixels <- function(
    n_rows   = 8L,
    n_cols   = 8L,
    n_states = 2L,
    colours  = NULL,
    grid     = TRUE
) {

  # Check inputs
  .check_n_arg_numeric(n_rows)
  .check_n_arg_numeric(n_cols)
  .check_n_arg_numeric(n_states)
  .check_colours_char(colours)
  .check_colours_len(n_states, colours)
  .check_grid(grid)

  # Convert to integer if required
  n_rows   <- .convert_to_int(n_rows)
  n_cols   <- .convert_to_int(n_cols)
  n_states <- .convert_to_int(n_states)

  # Generate a palette of gradated greys if colours not provided by user
  if (is.null(colours)) {
    get_greys <- grDevices::colorRampPalette(c("white", "grey20"))
    colours   <- get_greys(n_states)
  }

  # Initiate matrix, draw, let user interact
  m <- matrix(0L, n_rows, n_cols)
  .plot_canvas(m, n_states, colours)
  if (grid) .add_grid(m)
  m <- .repeat_loop(m, n_states, colours, grid)

  # Add class and colours as attributes to returned matrix
  class(m) <- "pixeltrix"
  attr(m, "colours") <- stats::setNames(colours, seq(0, n_states - 1))

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
#' @param colours Character vector. As many named/hex colours as 'n_state'. Each
#'     click in the interactive plot will cycle a pixel through these colours.
#'     Defaults to NULL, which results in an attempt to find and use the
#'     'colours' attribute (a named character vector) of the input matrix, 'm'.
#'     This attribute is added by default to matrices created with
#'     \code{\link{click_pixels}} (recommended).
#' @param grid Logical. Should a black boundary line be placed around the pixels
#'     to help differentiate between them? Defaults to TRUE.
#'
#' @details Click repeatedly the pixels in the interactive plotting window to
#'     cycle through the provided number of 'states'. The initial state value is
#'     0 and successive clicks increase it by 1, wrapping back to 0 once the
#'     maximum number of states is exceeded. Press the ESCAPE key to exit the
#'     interactive mode.
#' @details If your editor opens a separate graphics window (i.e. not RStudio),
#'     each click may result in a brief flash as the image refreshes, while a
#'     resized window may return to its original dimensions. You may also hear a
#'     bell sound on click, which you can disable by setting
#'     `options(locatorBell = FALSE)`.
#'
#' @return A 'pixeltrix'-class matrix. The zero-indexed values correspond to the
#'     state of each pixel, which is determined by the number of clicks a user
#'     gave each pixel. Has a named character-vector attribute, 'colours', which
#'     maps the matrix values to hex colours provided by the user (or a gradated
#'     set of greys provided by default when the 'colours' argument is NULL).
#'
#' @export
#'
#' @examples \dontrun{
#' # Create a 3 x 4 pixel matrix with 3 possible states to cycle through
#' my_matrix <- click_pixels(
#'   n_rows   = 3L,
#'   n_cols   = 4L,
#'   n_states = 3L,
#'   colours  = c("white", "red", "#0000FF")
#' )
#'
#'.# Update the original matrix
#' my_matrix_edited <- edit_pixels(m = my_matrix)
#'
#' # Update the original matrix with additional state, different colours
#' my_matrix_augmented <- edit_pixels(
#'   m        = my_matrix,
#'   n_states = 4L,  # one more than in the original
#'   colours  = c("bisque3", "orchid", "chartreuse", "olivedrab")
#' )}
edit_pixels <- function(
    m,
    n_states = NULL,
    colours  = NULL,
    grid     = TRUE
) {

  # Check inputs
  .check_matrix(m)
  .check_grid(grid)
  .check_n_arg_numeric(n_states, null_allowed = TRUE)
  .check_n_states_size(m, n_states)

  # Handle n_states
  if (!is.null(n_states)) {  # if provided, convert to integer
    n_states <- as.integer(n_states)
  } else if (is.null(n_states) & !is.null(attr(m, "colours"))) {  # via attribute
    n_states <- length(attr(m, "colours"))
  } else if (is.null(n_states) & is.null(attr(m, "colours"))) {  # via matrix
    n_states <- max(unique(as.vector(m)) + 1L)
  }

  # Handle colours if not provided
  if (is.null(colours) & !is.null(attr(m, "colours"))) {  # via attribute
    colours <- attr(m, "colours")
  } else if (is.null(colours)) {  # otherwise a grey palette
    get_greys <- grDevices::colorRampPalette(c("white", "grey20"))
    colours <- get_greys(n_states)
  }

  # Check n_states and colours values match
  .check_colours_states(m, n_states, colours)

  # Draw matrix, let user interact
  .plot_canvas(m, n_states, colours)
  if (grid) .add_grid(m)
  m <- .repeat_loop(m, n_states, colours, grid)

  # Add class and colours as attributes to returned matrix
  class(m) <- "pixeltrix"
  attr(m, "colours") <- stats::setNames(colours, seq(0, n_states - 1))

  m

}

#' Coerce to a 'pixeltrix' Object
#'
#' Functions to check if an object is of 'pixeltrix' class, or coerce to it if
#' possible.
#'
#' @param m A matrix of integers to coerce.
#'
#' @details To be successfully coerced, `m` must be a matrix composed only of
#'     integers.
#'
#' @return \code{as_pixeltrix} returns an object of class 'pixeltrix' if
#'     possible. \code{is_pixeltrix} returns \code{TRUE} if the object has class
#'     'pixeltrix', otherwise \code{FALSE}. If coerced, a named character-vector
#'     attribute, 'colours', is also added, which maps the matrix values to a
#'     gradated palette of greys in hex form.
#'
#' @examples
#' m <- matrix(c(0L, 1L, 1L, 0L), 2, 2)
#' is_pixeltrix(m)
#' m
#'
#' m <- as_pixeltrix(m)
#' is_pixeltrix(m)
#' m
#'
#' @export
as_pixeltrix <- function(m) {

  .check_matrix(m)

  if (inherits(m, "pixeltrix")) {
    return(m)
  }

  n_states <- max(unique(as.vector(m)) + 1L)
  get_greys <- grDevices::colorRampPalette(c("white", "grey20"))
  colours <- get_greys(n_states)

  class(m) <- "pixeltrix"
  attr(m, "colours") <- stats::setNames(colours, seq(0, n_states - 1))

  m

}

#' @rdname as_pixeltrix
#' @export
is_pixeltrix <- function(m) {
  inherits(m, "pixeltrix")
}
