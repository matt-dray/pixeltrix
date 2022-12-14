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

  # Random colour palette if none provided
  if (is.null(colours)) {

    warning(
      "Applying random colours. Set arg 'colours' for your own palette.",
      call. = FALSE
    )

    colours <- sample(
      grDevices::colours(),
      length(unique(as.numeric(m)))
    )

  }

  par_start <- graphics::par(mar = rep(0, 4))

  graphics::image(
    t(m[nrow(m):1, ]),  # reverse matrix rows and transpose
    col = colours,
    axes = FALSE,
    xlab = "",
    ylab = "",
    ...
  )

  on.exit(graphics::par(par_start))  # revert to user's original settings

}

#' Create Frames of a Pixel Animation
#'
#' Opens a new interactive plotting canvas with a grid of clickable squares
#' ('pixels'). When finished, the user is prompted to provide another.
#'
#' @param n_rows Integer. The number of 'pixels' high that the plot should be.
#'     Numeric values are coerced to integer.
#' @param n_cols Integer. The number of 'pixels' wide that the plot should be.
#'     Numeric values are coerced to integer.
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
#'     mode. You'll be prompted interactively in the console to add a new frame
#'     or not. If you refuse a new frame, you'll be returned a list of matrices,
#'     each of which contain the state values of each pixel for each frame of
#'     your animation.
#'
#' @return A list of matrices.
#'
#' @export
#'
#' @examples \dontrun{m <- frame_pixels(n_rows = 8, n_cols = 8, n_states = 3)}
frame_pixels <- function(
    n_rows   = 8L,
    n_cols   = 8L,
    n_states = 2L,
    grid     = TRUE
) {

  m_list <- list()

  m <- click_pixels(n_rows, n_cols, n_states, grid)

  m_list[[1]] <- m

  repeat {

    answer <- readline("Add a frame? y/n: ")

    if (substr(answer, 1, 1) == "y") {
      m <- edit_pixels(m, n_states)
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

#' Write Frames of a Pixel Animation to GIF
#'
#' Draws each list element (matrices) from the output of \code{\link{frame_pixels}}
#' and writes it to an animated gif. Requires user to install the 'gifski'
#' package.
#'
#' @param frames A list of matrices preferably produced by \code{\link{frame_pixels}}.
#'     Each is a matrix with the same dimension and possible values that
#'     represents a single frame of an animation.
#' @param colours A character vector of named colours. One for each value in m,
#'     the provided matrix. The order you provide the colours matches the order
#'     of the values in the matrix, from 0 to n. Defaults to NULL, which means
#'     random colours will be selected on your behalf.
#' @param file A filepath expressed as a character vector, ending with
#'     extension '.gif'. This is where the output animation will be written.
#' @param ...  Parameters to pass to \code{\link[gifski]{save_gif}} (you must
#'     have 'gifski' installed).
#'
#' @return Nothing.
#'
#' @export
#'
#' @examples \dontrun{
#' # Create interactively a list of matrices, i.e. frames of an animation
#' my_frames <- frame_pixels(n_rows = 8, n_cols = 8, n_states = 3)
#'
#' # Write
#' gif_pixels(
#'   frames = my_frames,
#'   colours = c("black", "blue", "green"),  # one colour per matrix value
#'   tempfile("example", ".gif")  # location to write GIF
#' )
#' }
gif_pixels <- function(
    frames,
    colours = NULL,
    file,
    ...
) {

  if (!inherits(frames, "list")) {
    stop(
      "Argument 'frames' must be a list of matrices of the same size, ",
      "preferably produced by the frame_pixels() function.",
      call. = FALSE
    )
  }

  if (length(seq(0, max(as.vector(unlist(frames))))) < length(colours)) {
    stop(
      "Length of argument 'colours' should not exceed the number of unique ",
      "pixel states in matrix 'm'.",
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
        frames,
        function(frame) {
          if (is.null(colours)) {
            draw_pixels(frame)
          } else {
            draw_pixels(frame, colours)
          }
        }
      )
    ),
    gif_file = file,
    ...
  )

}
