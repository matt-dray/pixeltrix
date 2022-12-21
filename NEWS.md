# pixeltrix 0.2.0

* A named character of colours is now provided as an extra attribute to matrices output from `click_pixels()` (#3, #17, thanks @TimTaylor).
* A named character vector of colours is now accepted as input to `click_pixels()`, `edit pixels()`, `draw_pixels()` and `frame_pixels()`.
* Reused input checks have been generalised into 'R/utils-check.R'.
* Updated and expanded function documentation.
* Expanded tests to cover argument input errors.

# pixeltrix 0.1.3

* Fixed lack of `n_states()` being passed to `edit_pixels()` in `frame_pixels()` (#18, thanks @TimTaylor), replacing dots in `frame_pixels()` with full set of arguments to pass to `click_pixels()` and `edit_pixels()`.
* Altered slightly the title and description of the package.
* Set default canvas dimensions to 8 by 8.

# pixeltrix 0.1.2

* Fixed integer check in `click_pixels()`.

# pixeltrix 0.1.1

* Added `draw_pixels()` to plot the matrix with `image()` to the plotting window (#12).
* Added `frame_pixels()` and `gif_pixels()` to capture successive 'frames' of an animation and write it to a gif (#13).
* Suggested {gifski} for creating gifs (towards #15).
* Provided to the user some instruction messages when they enter interactive mode.
* Improved code commentary.
* Added two matrix outputs as example datasets (Pokemon and Mario).

# pixeltrix 0.1.0

* Added basic error tests.
* Allowed for single row and single column matrices to be accepted by `click_pixels()` and `edit_pixels()` (#4).
* Removed redundancies in function documentation.

# pixeltrix 0.0.0.9004

* Added an `edit_pixels()` function so that a matrix created with `click_pixels()` can be updated (#6).
* Moved support functions to utils.R.
* Simplified the README and added a blog badge.

# pixeltrix 0.0.0.9003

* Added argument `n_states` to `click_pixels()` that lets users choose the number of 'states' that a pixel can take (#4).
* Added argument `grid` to `click_pixels()` that lets users turn on or off a grid overlay (#5).
* Changed colours to greyscale.
* This version was the basis for [the original blogpost](https://www.rostrum.blog/2022/09/24/pixeltrix/).

# pixeltrix 0.0.0.9002

* Went the non-Shiny route and used `locator()` and `image()` for interactivity in the `click_pixel()` function (#2).
* Added GitHub Actions for R-CMD check, tests, {pkgdown} webbite.
* This version was [previewed in a tweet](https://twitter.com/mattdray/status/1573053714788753408?s=20&t=0HzMLD0fjc5evjtCKqQY3g).

# pixeltrix 0.0.0.9001

* Added basic image-click template app [from RStudio](https://shiny.rstudio.com/gallery/image-interaction-basic.html) as the function `pixeltrix()`.

# pixeltrix 0.0.0.9000

* There is no functionality, lol.
