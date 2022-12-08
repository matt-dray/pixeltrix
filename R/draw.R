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
#' @param ... Additional graphical parameters passed to
#'     \code{\link[graphics]{image}} and thus \code{\link[graphics]{plot}}.
#'
#' @return Nothing.
#'
#' @export
#'
#' @examples \dontrun{
#'   m <- click_pixels(n_states = 3)
#'   draw_pixels(m, c("black", "blue", "green"))  # one colour per state
#' }
draw_pixels <- function(m, colours = NULL, ...) {

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

  if (is.null(colours)) {
    colours <- sample(
      grDevices::colours(),
      length(unique(as.numeric(m)))
    )
  }

  m_rev <- m[, seq(ncol(m), 1)]

  par_orig <- par(mar = rep(0, 4))

  graphics::image(
    m_rev,
    col = colours,
    xaxt = "n",
    yaxt = "n",
    ...
  )

  on.exit(par(par_orig))

}
