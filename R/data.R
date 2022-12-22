#' Example Sprite Matrix: Pokémon
#'
#' A matrix output from \code{\link{click_pixels}} that represents the pixels of
#' a player sprite from Pokémon.
#'
#' @examples \dontrun{
#'     # Plot the matrix as an image
#'     draw_pixels(
#'       m = pixeltrix::pkmn_sprite,
#'       colours = c("#9bbc0f", "#8bac0f", "#306230")
#'     )
#' }
#'
#' @format A matrix with 16 rows and 14 columns, taking integers from 0 to 2.
#'
#' @source Hand-copied from Pokemon (1996), The Pokemon Company.
"pkmn_sprite"

#' Example Sprite Matrix: Mario
#'
#' A list of matrices output from \code{\link{frame_pixels}} that represent the
#' pixels of the Mario sprite from Super Mario Bros. Each matrix is a step in
#' the walk cycle.
#'
#' @examples \dontrun{
#'     # Write a list of matrices to a gif
#'     gif_pixels(
#'       frames = pixeltrix::mario_frames,
#'       colours = c("#8861FE", "#F6B95B", "#FFFFFF", "#29A41F"),
#'       file = "super-mario.gif",
#'       delay = 0.15  # passed to gifski::save_gif()
#'     )
#' }
#'
#' @format A list of matrices, each with 16 rows and 16 columns, taking integers
#'     from 0 to 2.
#'
#' @source Super Mario Bros (1983), Nintendo.
"mario_frames"
