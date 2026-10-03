# Open a device that supports locator(); return TRUE if we opened a new one
.open_interactive_device <- function() {
  # RStudio's built-in device supports locator()
  is_rstudio <- identical(.Platform[["GUI"]], "RStudio")
  if (is_rstudio) {
    return(FALSE)
  }

  # Reuse the current device if it's already a native one
  native <- c("X11", "X11cairo", "quartz", "windows", "windows_gd")
  if (
    grDevices::dev.cur() > 1 && any(names(grDevices::dev.cur()) %in% native)
  ) {
    return(FALSE)
  }

  sysname <- Sys.info()[["sysname"]]

  is_ok <- switch(
    sysname,
    Windows = TRUE,
    Darwin = isTRUE(capabilities("aqua")),
    isTRUE(capabilities("X11"))
  )

  if (!is_ok) {
    stop(
      "No interactive graphics device available. ",
      "click_pixels() needs a native window (X11, quartz or windows) ",
      "or RStudio.",
      call. = FALSE
    )
  }

  switch(
    sysname,
    Windows = grDevices::windows(),
    Darwin = grDevices::quartz(),
    grDevices::x11()
  )

  TRUE
}
