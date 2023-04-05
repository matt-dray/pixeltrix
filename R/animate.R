
#' Create Frames of a Pixel Animation
#'
#' Opens a new interactive plotting canvas with a grid of clickable squares
#' ('pixels'). When finished, the user is prompted to provide another.
#'
#' @param n_rows Integer. The number of pixels high that the plot should be.
#'     Numeric values are coerced to integer.
#' @param n_cols Integer. The number of pixels wide that the plot should be.
#'     Numeric values are coerced to integer.
#' @param n_states Integer. The number of states that a pixel can be. Click a
#'     pixel to cycle through the states. Numeric values are coerced to integer.
#'     See details.
#' @param colours Character vector. As many named/hex colours as n_state. Each
#'     click in the interactive plot will cycle a pixel through these colours.
#'     Defaults to NULL, which results in an attempt to find and use the
#'     'colours' attribute (named character vector) of the input matrix, 'm'.
#'     This attribute is added by default to matrices created with
#'     \code{\link{click_pixels}} (recommended).
#' @param grid Logical. Should a boundary line be placed around the pixels to
#'     make them easier to differentiate between them? Defaults to TRUE.
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
#' @details If your editor opens a separate graphics window (i.e. not RStudio),
#'     each click may result in a brief flash as the image refreshes, while a
#'     resized window may return to its original dimensions. You may also hear a
#'     bell sound on click, which you can disable by setting
#'     `options(locatorBell = FALSE)`.
#'
#' @return A list of matrices.
#'
#' @export
#'
#' @examples \dontrun{
#'     # Begin interactive sequence to create animation frames
#'     my_frames <- frame_pixels(
#'       n_rows   = 16L,
#'       n_cols   = 16L,
#'       n_states = 3L,
#'       colours  = c("grey25", "green", "#0000FF")
#'     )
#' }
frame_pixels <- function(
    n_rows   = 8L,
    n_cols   = 8L,
    n_states = 2L,
    colours  = NULL,
    grid     = TRUE
) {

  .check_n_arg_numeric(n_rows)
  .check_n_arg_numeric(n_cols)
  .check_n_arg_numeric(n_states)
  .check_colours_char(colours)
  .check_colours_len(n_states, colours)
  .check_grid(grid)

  m_list  <- list()

  m_first <- click_pixels(n_rows, n_cols, n_states, colours, grid)
  m_list  <- append(m_list, list(m_first))

  repeat {

    answer <- readline("Add a frame? y/n: ")

    if (substr(answer, 1, 1) == "y") {
      m_last <- m_list[[length(m_list)]]
      m_new  <- edit_pixels(m_last, grid = grid)
      m_list <- append(m_list, list(m_new))
      message("Current frame count: ", length(m_list))
    }

    if (substr(answer, 1, 1) == "n") {
      message("Final frame count: ", length(m_list))
      break
    }

  }

  m_list

}

#' Write Frames of a Pixel Animation to GIF
#'
#' Plots (using \code{\link{draw_pixels}}) each matrix from a list (ideally
#' created using \code{\link{frame_pixels}}) and writes it to an animated GIF.
#' Requires the 'gifski' package.
#'
#' @param frames A list of matrices. preferably produced by \code{\link{frame_pixels}}.
#'     Each matrix in the list is a frame of the final animation.
#' @param colours A character vector of named colours. One for each unique value
#'     in the matrices of the 'frames' list. The order you provide the colours
#'     matches the sorted order of the values in the matrix. Defaults to NULL,
#'     which means colours will be extracted from the 'colours' attribute of the
#'     matrices (which is added to the object when using the recommended
#'     \code{\link{frame_pixels}} function), otherwise a gradated palette of
#'     greys will be selected.
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
#'     # Begin interactive sequence to create animation frames
#'     my_frames <- frame_pixels(
#'       n_rows   = 16L,
#'       n_cols   = 16L,
#'       n_states = 3L,
#'       colours  = c("grey25", "green", "#0000FF")
#'     )
#'
#'     # Write list of matrices to gif (requires 'gifski' installation)
#'     gif_pixels(
#'       frames = my_frames,
#'       file = "example.gif",  # location to write GIF
#'       delay = 0.1            # passed to gifski::save_gif()
#'     )
#' }
gif_pixels <- function(
    frames,
    colours = NULL,
    file,
    ...
) {

  .check_frames_dims(frames)
  .check_file_gif(file)

  # Retrieve n_states from attributes or matrix values
  if (!is.null(attr(frames[[1]], "colours"))) {
    n_states <- length(attr(frames[[1]], "colours"))
  } else if (is.null(attr(frames, "colours"))) {
    n_states <- max(unique(unlist(frames))) + 1L
  }

  # If the first frame has a 'colours' attribute, then use these
  if (is.null(colours) & !is.null(attr(frames[[1]], "colours"))) {
    colours <- attr(frames[[1]], "colours")
  }

  # If no 'colours' attribute and colours is NULL, then choose gradated greys
  if (is.null(colours)) {
    get_greys <- grDevices::colorRampPalette(c("white", "grey20"))
    colours   <- get_greys(n_states)  # gradated colours from white to dark grey
  }

  .check_colours_char(colours)
  .check_colours_states(frames, n_states, colours)

  # Write to gif
  gifski::save_gif(
    invisible(lapply(frames, function(frame) draw_pixels(frame, colours))),
    gif_file = file,
    ...
  )

}
