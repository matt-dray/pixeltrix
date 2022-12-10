#' Example Sprite Matrix: Pokemon
#'
#' A matrix output from \code{\link{click_pixels}} that represents the pixels of
#' a player sprite from Pokemon Blue.
#'
#' @examples \dontrun{
#' # Plot the matrix as an image
#' draw_pixels(
#'   m = pixeltrix::blue,
#'   colours = c("white", "#879afb", "gray20")
#' )
#' }
#'
#' @format A matrix with 16 rows and 14 columns, taking integers from 0 to 2.
#'
#' @source Hand-copied from Pokemon Blue (1996), The Pokemon Company.
"blue"

#' Example Sprite Matrix: Mario
#'
#' A list of matrices output from \code{\link{frame_pixels}} that represent the
#' pixels of the Mario sprite from Super Mario Bros. Each matrix is a step in
#' the walk cycle.
#'
#' @examples \dontrun{
#' # Write the list of matrices to a gif
#' gif_pixels(
#'   frames = pixeltrix::mario,
#'   colours = c("white", "#FDA428", "#FC0D1B", "#A32B2E"),
#'   file = "mario.gif",
#'   delay = 0.15
#' )
#' }
#'
#' @format A list of matrices, each with 16 rows and 16 columns, taking integers
#'     from 0 to 2.
#'
#' @source Super Mario Bros (1983), Nintendo Entertainment System, Nintendo.
"mario"
