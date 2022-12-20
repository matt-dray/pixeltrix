#' Draw 'Pixel' Matrix in a Plot Window
#'
#' Opens a plot window and draws a provided matrix. Designed for use with the
#' output from \code{\link{click_pixels}} (or \code{\link{edit_pixels}}).
#'
#' @param m A matrix of integers. The maximum value is assumed to be the number
#'     of pixel states desired. Override by supplying a 'n_states' value larger
#'     than the maximum in the matrix.
#' @param colours A character vector of named colours. One for each value in m,
#'     the provided matrix. The order you provide the colours matches the order
#'     of the values in the matrix, from 0 to n. Defaults to NULL, which means
#'     random colours will be selected on your behalf.
#'
#' @return Nothing.
#'
#' @export
#'
#' @examples \dontrun{
#'   my_matrix <- click_pixels(n_states = 3)
#'   draw_pixels(my_matrix, c("black", "#0000FF", "green"))  # one colour per state
#' }
draw_pixels <- function(m, colours = NULL) {

  if (!inherits(m, "matrix") | !is.numeric(m) | all(diff(1:3) != 1)) {
    stop(
      "Argument 'm' must be a matrix composed of consecutive numeric values.",
      call. = FALSE
    )
  }

  if (length(seq(0, max(as.vector(m)))) < length(colours)) {
    stop(
      "Length of argument 'colours' should not exceed the number of unique ",
      "pixel states in matrix 'm'.",
      call. = FALSE
    )
  }

  # Take colours from attributes of input matrix, if present
  if (is.null(colours) & !is.null(attr(m, "colours"))) {
    colours <- attr(m, "colours")
  }

  # If matrix has no 'colour' attribute, create gradated grey palette
  if (is.null(colours)) {
    get_greys <- grDevices::colorRampPalette(c("white", "grey20"))
    colours   <- get_greys(n_states)  # gradated colours from white to dark grey
  }

  par_start <- graphics::par(mar = rep(0, 4))

  graphics::image(
    t(m[nrow(m):1, ]),  # reverse matrix rows and transpose
    col = colours,
    axes = FALSE,
    xlab = "",
    ylab = ""
  )

  on.exit(graphics::par(par_start))  # revert to user's original settings

}
