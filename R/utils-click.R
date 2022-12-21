# Loop continuously to accept a click, update matrix values, then re-plot
.repeat_loop <- function(m, n_states, colours, grid) {

  message("Click squares in the plot window. Press <Esc> to end.")

  repeat {

    point <- .locate_on_grid(m)

    if (is.null(point)) break

    m <- .update_matrix(m, point, n_states)

    grDevices::dev.off()

    .plot_canvas(m, n_states, colours)

    if (grid) .add_grid(m)

  }

  m

}

# Plot 'pixels' given the dimensions of the input matrix
.plot_canvas <- function(m, n_states, colours) {

  par_start <- graphics::par(mar = rep(0, 4))  # set margins, save current

  n_rows <- nrow(m)
  n_cols <- ncol(m)

  if (n_rows > 1 & n_cols > 1) {
    m <- t(m[seq(n_rows, 1), ])
  }

  # Transpose/reverse needed with pixel dimension of 1
  if (n_rows == 1) m <- t(m)
  if (n_cols == 1) m <- t(rev(m))

  graphics::image(
    m,
    zlim = c(0, n_states - 1),
    col  = colours,
    axes = FALSE,
    xlab = "",
    ylab = ""
  )

  on.exit(graphics::par(par_start))  # revert to user's original settings

}

# Draw a grid over the plotted matrix to differentiate 'pixels'
.add_grid <- function(m) {

  x_n <- ncol(m)

  if (x_n == 1) {
    x_lines <- c(-1, 1)  # boundaries are -1,1 if only one pixel on this axis
  }

  if (x_n > 1) {

    x_unit  <- 1 / (x_n - 1)  # width of one pixel

    x_lines <- seq(  # min/max pixel centres at -1,1, but there's 'overhang'
      0 - x_unit - (x_unit / 2),  # add half a pixel overhang at min
      1 + x_unit + (x_unit / 2),  # add half a pixel overhang at max
      x_unit
    )

  }

  y_n <- nrow(m)

  if (y_n == 1) {
    y_lines <- c(-1, 1)
  }

  if (y_n > 1) {

    y_unit  <- 1 / (y_n - 1)

    y_lines <- seq(
      0 - y_unit - (y_unit / 2),
      1 + y_unit + (y_unit / 2),
      y_unit
    )

  }

  # Draw gridlines to plot
  graphics::abline(v = x_lines)
  graphics::abline(h = y_lines)

}

# Get XY location of plotted 'pixel' that's been clicked by the user
.locate_on_grid <- function(m) {

  # Pixel centres, x axis
  x_n    <- ncol(m)            # number of pixels in the x dimension
  x_unit <- 1 / (x_n - 1)      # x width of pixels
  x_mids <- seq(0, 1, x_unit)  # full set of pixel centres on x axes

  # Pixel centres, y axis
  y_n    <- nrow(m)
  y_unit <- 1 / (y_n - 1)
  y_mids <- seq(0, 1, y_unit)

  point <- graphics::locator(1)  # prompt for interactive click

  if (length(point) == 0) {  # if early escape from locator()
    return(NULL)
  }

  # Calculate distances xy from clicked point to pixel centres
  x_diffs <- abs(point$x - x_mids)
  y_diffs <- rev(abs(point$y - y_mids))

  # Identify pixel closest to click
  point <- list(
    x = which.min(x_diffs),
    y = which.min(y_diffs)
  )

  # Default to 1 if there's no point
  if (length(point$x) == 0) point$x <- 1
  if (length(point$y) == 0) point$y <- 1

  return(point)

}

# Increment the value of the matrix that corresponds to the clicked 'pixel'
.update_matrix <- function(m, point, n_states) {

  states        <- seq(0L, n_states - 1L)  # available pixel states (0, 1, ...)
  current_state <- m[point$y, point$x]     # current state of pixel (e.g. 0)
  next_state    <- current_state + 1L      # next consecutive state (e.g. 1)

  if (next_state > n_states - 1L) {
    next_state <- states[1]  # wrap from last to first state (e.g. 0, 1, 0)
  }

  m[point$y, point$x] <- next_state  # update the state for that pixel

  m

}
