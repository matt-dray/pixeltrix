.check_matrix <- function(m) {

  if (!is.matrix(m) | !is.integer(m)) {
    stop(
      "Argument 'm' must be a matrix object composed of integers.",
      call. = FALSE
    )
  }

}

.check_n_numeric <- function(n_rows, n_cols, n_states) {

  if (
    is.logical(n_rows) | is.logical(n_states) | is.logical(n_cols) |
    !is.numeric(c(n_rows, n_cols, n_states))
  ) {
    stop(
      "Arguments 'n_rows', 'n_cols' and 'n_states' must be numeric values.",
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

.check_colours_len <- function(colours, n_states) {

  if (!is.null(colours) && (length(colours) != n_states)) {
    stop(
      "Argument 'colours' must be a character vector of length 'n_states'.",
      call. = FALSE
    )
  }

}

.check_colours_unique <- function(object, colours) {

  if (is.list(object)) {
    object <- unlist(object)
  }

  if (is.matrix(object)) (
    object <- as.vector(object)
  )

  states_len <- length(unique(object))

  if (length(colours) != states_len) {
    stop(
      "Length of argument 'colours' should match the number of unique ",
      "pixel states (", states_len, ").",
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
