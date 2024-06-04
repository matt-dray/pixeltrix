#' Draw 'Pixel' Matrix in a Plot Window
#'
#' Opens a plot window and draws a provided matrix. Designed for use with the
#' output from \code{\link{click_pixels}} (or \code{\link{edit_pixels}}).
#'
#' @param m A matrix of integers. The maximum value is assumed to be the number
#'     of pixel states desired. Override by supplying a 'n_states' value larger
#'     than the maximum in the matrix.
#' @param colours Character vector. As many named/hex colours as unique state
#'     values in 'm'. Each click in the interactive plot will cycle a pixel
#'     through these colours. Defaults to NULL, which results in an attempt to
#'     find and use the 'colours' attribute (a named character vector) of the
#'     input matrix, 'm', which is added by default to matrices created
#'     with \code{\link{click_pixels}} (recommended).
#'
#' @return Nothing.
#'
#' @export
#'
#' @examples \dontrun{
#' my_matrix <- click_pixels(n_states = 3L)
#' draw_pixels(my_matrix, c("black", "#0000FF", "green"))  # a colour per state}
draw_pixels <- function(m, colours = NULL) {

  .check_matrix(m)

  # Retrieve n_states from attributes or matrix values
  if (!is.null(attr(m, "colours"))) {
    n_states <- length(attr(m, "colours"))
  } else if (is.null(attr(m, "colours"))) {
    n_states <- max(unique(as.vector(m))) + 1L
  }

  # Take colours from attributes of input matrix, if present
  if (is.null(colours) & !is.null(attr(m, "colours"))) {
    colours <- attr(m, "colours")
  }

  # If matrix has no 'colours' attribute, create gradated grey palette
  if (is.null(colours) & is.null(attr(m, "colours"))) {
    get_greys <- grDevices::colorRampPalette(c("white", "grey20"))
    colours   <- get_greys(n_states)  # gradated colours from white to dark grey
  }

  # Check number of colours provided
  .check_colours_states(m, n_states, colours)

  par_start <- graphics::par(mar = rep(0, 4))  # set margins, store previous par

  graphics::image(
    t(m[nrow(m):1, ]),  # reverse matrix rows and transpose
    col = colours,
    axes = FALSE,
    xlab = "",
    ylab = ""
  )

  on.exit(graphics::par(par_start))  # revert to user's original settings

}
