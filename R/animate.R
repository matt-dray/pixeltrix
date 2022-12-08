#' Create Frames of a Pixel Animation
#'
#' Opens a new interactive plotting canvas with a grid of clickable squares
#' ('pixels'). When finished, the user is prompted to provide another.
#'
#' @param ... Parameters to pass to \code{\link{click_pixels}}.
#'
#' @return A list of matrices.
#'
#' @export
#'
#' @examples \dontrun{m <- frame_pixels(n_rows = 8, n_cols = 8)}
frame_pixels <- function(...) {

  m_list <- list()

  m <- click_pixels(...)

  m_list[[1]] <- m

  repeat {

    answer <- readline("Add a frame? y/n: ")

    if (substr(answer, 1, 1) == "y") {
      m <- edit_pixels(m)
      m_list <- append(m_list, list(m))
      message("Current frame count: ", length(m_list))
    }

    if (substr(answer, 1, 1) == "n") {
      message("Final frame count: ", length(m_list))
      break
    }

  }

  return(m_list)

}

#' Write Sprite Frames to Gif
#'
#' Draws each list element from the output of \code{\link{frame_pixels}} and
#' writes it to an animated gif.
#'
#' @param m_list
#' @param colours
#' @param file
#'
#' @return Nothing.
#'
#' @export
#'
#' @examples \dontrun{
#'   f <- frame_pixels(n_rows = 8, n_cols = 8, n_states = 3)
#'   gif_pixels(f, c("black", "blue", "green"), "~/Desktop/example.gif")  # one colour per state
#' }
gif_pixels <- function(
    m_list,
    colours,
    file = "~/Desktop/test.gif",
    ...
) {

  if (!inherits(m_list, "list")) {
    stop(
      "Argument 'm_list' must be a list of matrices of the same size, ",
      "preferably produced by the frame_pixels() function.",
      call. = FALSE
    )
  }

  if (
    !inherits(file, "character") |
    length(file) != 1 |
    substr(file, nchar(file) - 3, nchar(file)) != ".gif"
  ) {
    stop(
      "Argument 'file' must be a character-string filepath ending '.gif'.",
      call. = FALSE
    )
  }

  gifski::save_gif(
    invisible(
      lapply(
        # m_list[seq(length(m_list), 1)],
        m_list,
        function(frame) draw_pixels(frame, colours)
      )
    ),
    gif_file = file,
    ...
  )

}
