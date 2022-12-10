# Loop continuously to accept a click, update matrix values, then re-plot
.repeat_loop <- function(m, n, g) {

  repeat {

    p <- .locate_on_grid(m)

    if (is.null(p)) break

    m <- .update_matrix(m, p, n)

    grDevices::dev.off()

    .plot_canvas(m, n)

    if (g) .add_grid(m)

  }

  m

}

# Plot 'pixels' given the dimensions of the input matrix
.plot_canvas <- function(m, n) {

  par_start <- graphics::par(mar = rep(0, 4))  # set margins, save current

  n_rows <- nrow(m)
  n_cols <- ncol(m)

  if (n_rows > 1 & n_cols > 1) {
    m <- t(m[nrow(m):1, ])
  }

  # Transposition and reversal required with pixel dimension of 1
  if (n_rows == 1) m <- t(m)
  if (n_cols == 1) m <- t(rev(m))

  # Generate greyscale colour palette, darker for higher values
  pal <- grDevices::colorRampPalette(c("white", "black"))

  graphics::image(
    m,
    zlim = c(0, n),
    col  = pal(n + 1),
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

  p <- graphics::locator(1)  # prompt for interactive click

  if (length(p) == 0) {  # if early escape from locator()
    return(NULL)
  }

  # Calculate distances xy from clicked point to pixel centres
  x_diffs <- abs(p$x - x_mids)
  y_diffs <- rev(abs(p$y - y_mids))

  # Identify pixel closest to click
  p <- list(
    x = which.min(x_diffs),
    y = which.min(y_diffs)
  )

  #
  if (length(p$x) == 0) p$x <- 1
  if (length(p$y) == 0) p$y <- 1

  return(p)

}

# Increment the value of the matrix that corresponds to the clicked 'pixel'
.update_matrix <- function(m, p, n) {  # matrix, pixel coordinates, n_states

  states <- seq(0L, n - 1L)         # available pixel state values (0, 1, ...)
  current_state <- m[p$y, p$x]      # current state value of pixel (e.g. 0)
  next_state <- current_state + 1L  # next consecutive state value (e.g. 1)

  if (next_state > n - 1L) {
    next_state <- states[1]  # wrap from last to first state value (e.g. 0, 1, 0)
  }

  m[p$y, p$x] <- next_state  # update the state value in the matrix for that pixel

  return(m)

}
