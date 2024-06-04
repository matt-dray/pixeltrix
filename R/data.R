#' Example Sprite Matrix: 'pixeltrix' Package Logo Text
#'
#' A matrix output from \code{\link{click_pixels}} that represents the
#' text of the pixeltrix package logo, which is the word 'pixeltrix' written
#' in a font with letters that are 3 by 3 pixels.
#'
#' @examples \dontrun{
#' # Plot the matrix as an image
#' draw_pixels(m = pixeltrix::logo)}
#'
#' @format A 'pixeltrix'-class matrix with 10 rows and 21 columns, taking
#'     integers from 0 to 2.
"logo"

#' Example Sprite Matrix: Mario
#'
#' A list of matrices output from \code{\link{frame_pixels}} that represent the
#' pixels of the Mario sprite from Super Mario Bros. Each matrix is a step in
#' the walk cycle.
#'
#' @examples \dontrun{
#' # Write the list of matrices to a gif
#' gif_pixels(
#'   frames = pixeltrix::mario_frames,
#'   file = "mario.gif",
#'   delay = 0.15  # passed to gifski::save_gif()
#' )}
#'
#' @format A list of 'pixeltrix'-class matrices, each with 16 rows and 16
#'     columns, taking integers from 0 to 2.
#'
#' @source Super Mario Bros (1983), Nintendo.
"mario_frames"

#' Example Sprite Matrix: Pokémon
#'
#' A matrix output from \code{\link{click_pixels}} that represents the pixels of
#' a player sprite from Pokémon.
#'
#' @examples \dontrun{
#' # Plot the matrix as an image
#' draw_pixels(
#'   m = pixeltrix::pkmn_sprite,
#'   colours = c("#9bbc0f", "#8bac0f", "#306230")
#' )}
#'
#' @format A 'pixeltrix'-class matrix with 16 rows and 14 columns, taking
#'     integers from 0 to 2.
#'
#' @source Hand-copied from Pokemon (1996), The Pokemon Company.
"pkmn_sprite"
