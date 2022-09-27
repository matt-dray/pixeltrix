
.repeat_loop <- function(m, n, g) {

  repeat {

    p <- .locate_on_grid(m)

    if (is.null(p)) {

      break

    } else {

      m <- .update_matrix(m, p, n)

      grDevices::dev.off()

      .plot_canvas(m, n)

      if (g) {
        .add_grid(m)
      }

    }

  }

  m

}

.plot_canvas <- function(m, n) {

  graphics::par(mar = rep(1, 4))

  n_rows <- nrow(m)
  n_cols <- ncol(m)

  if (n_rows > 1 & n_cols > 1) {
    m <- t(m[nrow(m):1, ])
  }

  if (n_rows == 1) {
    m <- as.matrix(rev(m))
  }

  if (n_cols == 1) {
    m <- t(rev(m))
  }

  pal <- grDevices::colorRampPalette(c("white", "black"))

  graphics::image(
    m,
    zlim = c(0, n),
    col  = pal(n + 1),
    xlab = "",
    ylab = "",
    axes = FALSE
  )

}

.add_grid <- function(m) {

  x_n <- ncol(m)
  if (x_n > 1) {
    x_unit  <- 1 / (x_n - 1)
    x_lines <- seq(0 - x_unit - (x_unit / 2), 1 + x_unit + (x_unit / 2), x_unit)
  } else if (x_n == 1) {
    x_lines <- c(-1, 1)
  }

  y_n <- nrow(m)
  if (y_n > 1) {
    y_unit  <- 1 / (y_n - 1)
    y_lines <- seq(0 - y_unit - (y_unit / 2), 1 + y_unit + (y_unit / 2), y_unit)
  } else if (y_n == 1) {
    y_lines <- c(-1, 1)
  }

  graphics::abline(v = x_lines)
  graphics::abline(h = y_lines)

}

.locate_on_grid <- function(m) {

  x_n    <- ncol(m)
  x_unit <- 1 / (x_n - 1)
  x_mids <- seq(0, 1, x_unit)

  y_n    <- nrow(m)
  y_unit <- 1 / (y_n - 1)
  y_mids <- seq(0, 1, y_unit)

  p <- graphics::locator(1)

  if (length(p) == 0) {

    return(NULL)

  } else {

    x_diffs <- abs(p$x - x_mids)
    y_diffs <- rev(abs(p$y - y_mids))

    list(
      x = which.min(x_diffs),
      y = which.min(y_diffs)
    )

  }

}

.update_matrix <- function(m, p, n) {

  states <- seq(0L, n - 1L)
  current_state <- m[p$y, p$x]
  next_state <- current_state + 1L

  if (next_state > n - 1L) {
    next_state <- states[1]
  }

  m[p$y, p$x] <- next_state

  return(m)

}
