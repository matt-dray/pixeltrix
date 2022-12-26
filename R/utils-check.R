.check_matrix <- function(m) {

  if (!is.matrix(m) | !is.integer(m)) {
    stop(
      "Argument 'm' must be a matrix object composed of integers.",
      call. = FALSE
    )
  }

}

.check_n_arg_numeric <- function(n_arg, null_allowed = FALSE) {

  if (!null_allowed) {  # used in click_pixels, where defaults are provided

    if (is.logical(n_arg) | !is.numeric(c(n_arg))) {
      stop(
        "Argument '", deparse(substitute(n_arg)), "' must be numeric.",
        call. = FALSE
      )
    }

  }

  if (null_allowed) {  # used in edit_pixels, where default n_states is NULL

    if (!is.null(n_arg) && !is.numeric(n_arg)) {
      stop(
        "Argument '", deparse(substitute(n_arg)), "' must be numeric or NULL.",
        call. = FALSE
      )
    }

  }


}

.check_n_states_size <- function(m, n_states) {

  m_max <- max(m + 1L)

  if (!is.null(n_states) && n_states < m_max) {
    stop(
      "Argument 'n_states' (", n_states, " detected) must be equal or greater ",
      "than the maximum value in the matrix 'm' (", m_max, " detected).",
      call. = FALSE
    )
  }

}

.check_colours_char <- function(colours) {

  if (!is.null(colours)) {
    if (!inherits(colours, "character")) {
      stop(
        "Argument 'colours' must be a character vector of named or hex colours.",
        call. = FALSE
      )
    }
  }

}

.check_colours_len <- function(n_states, colours) {

  if (!is.null(colours) && (length(colours) != n_states)) {
    stop(
      "Argument 'colours' (", length(colours), " values provided) must be a ",
      "character vector of length 'n_states' (", n_states, ").",
      call. = FALSE
    )
  }

}

.check_colours_states <- function(object, n_states, colours) {

  if (is.null(n_states)) {

    if (is.matrix(object)) {  # edit_pixels() is a matrix

      colours_attr <- attr(object, "colours")

      if (!is.null(colours_attr)) {
        n_states <- length(colours_attr)
      }

      if (is.null(colours_attr)) {
        object <- as.vector(object)
        n_states <- max(unique(object)) + 1L
      }

    }

    if (is.list(object)) {  # frame_pixels() input is a list

      colours_attr <- attr(object[[1]], "colours")

      if (!is.null(colours_attr)) {
        n_states <- length(colours_attr)
      }

      if (is.null(colours_attr)) {
        object <- unlist(object)
        n_states <- max(unique(object)) + 1L
      }

    }

  }

  if (length(colours) != n_states) {
    stop(
      "Number of colours (", length(colours), " detected) should match ",
      "the number of pixel states (", n_states, " detected).",
      call. = FALSE
    )
  }

}

.check_grid <- function(grid) {

  if (!is.logical(grid)) {
    stop(
      "Argument 'grid' must be TRUE or FALSE.",
      call. = FALSE
    )
  }

}

.check_frames_dims <- function(frames) {

  if (
    !is.list(frames) |
    !all(sapply(frames, function(frame) identical(dim(frame), dim(frames[[1]]))))
  ) {
    stop(
      "Argument 'frames' must be a list of matrices of the same dimensions ",
      "(preferably produced by the frame_pixels() function).",
      call. = FALSE
    )
  }

}

.check_file_gif <- function(file) {

  if (
    !inherits(file, "character") |
    length(file) != 1 |
    tools::file_ext(file) != "gif"
  ) {
    stop(
      "Argument 'file' must be a character-string filepath ending '.gif'.",
      call. = FALSE
    )
  }

}
