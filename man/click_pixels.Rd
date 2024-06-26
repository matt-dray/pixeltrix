% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/click.R
\name{click_pixels}
\alias{click_pixels}
\title{Click 'Pixels' in an Interactive Plot}
\usage{
click_pixels(
  n_rows = 8L,
  n_cols = 8L,
  n_states = 2L,
  colours = NULL,
  grid = TRUE
)
}
\arguments{
\item{n_rows}{Integer. The number of pixels high that the plot should be.
Numeric values are coerced to integer.}

\item{n_cols}{Integer. The number of pixels wide that the plot should be.
Numeric values are coerced to integer.}

\item{n_states}{Integer. The number of states that a pixel can be cycled
through with successive clicks. Numeric values are coerced to integer.
See details.}

\item{colours}{Character vector. As many named/hex colours as 'n_state'. Each
click in the interactive plot will cycle a pixel through these colours.
Defaults to NULL, which generates a gradation from white to dark grey.
See details.}

\item{grid}{Logical. Should a black boundary line be placed around the pixels
to help differentiate between them? Defaults to TRUE.}
}
\value{
A 'pixeltrix'-class matrix. The zero-indexed values correspond to the
state of each pixel, which is determined by the number of clicks a user
gave each pixel. Has a named character-vector attribute, 'colours', which
maps the matrix values to hex colours provided by the user (or a gradated
set of greys provided by default when the 'colours' argument is NULL).
}
\description{
Opens an interactive plot with a grid of squares ('pixels') that you can
click to cycle through. Returns a matrix 'blueprint' of your image.
}
\details{
Click repeatedly the pixels in the interactive plotting window to
cycle through the provided number of 'states'. The initial state value is
0 and successive clicks increase it by 1, wrapping back to 0 once the
maximum number of states is exceeded. Press the ESCAPE key to exit the
interactive mode.

If your editor opens a separate graphics window (i.e. not RStudio),
each click may result in a brief flash as the image refreshes, while a
resized window may return to its original dimensions. You may also hear a
bell sound on click, which you can disable by setting
\code{options(locatorBell = FALSE)}.
}
\examples{
\dontrun{
# Create a 16 x 16 pixel matrix with 3 possible pixel states
my_matrix <- click_pixels(
  n_rows   = 16L,
  n_cols   = 16L,
  n_states = 3L,
  colours  = c("blue", "#FF0000", "yellow")
)
}
}
