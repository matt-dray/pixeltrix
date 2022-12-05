
frame_pixels <- function(...) {

  m_list <- list()

  m <- click_pixels(...)

  m_list[[1]] <- m

  repeat {

    answer <- readline("Next frame? y/n: ")

    if (answer == "y") {
      m <- edit_pixels(m)
      m_list <- append(m_list, list(m))
    }

    if (answer == "n") {
      break
    }

  }

  return(m_list)

}

animate_pixels <- function(
    m_list,
    colours,
    file = "~/Desktop/test.gif",
    ...
) {

  gifski::save_gif(
    invisible(
      lapply(
        m_list,
        function(f) draw_pixels(f, colours)
      )
    ),
    gif_file = file,
    ...
  )

}
