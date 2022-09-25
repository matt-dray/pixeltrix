# pixeltrix 0.0.0.9004

* Added an `edit_pixels()` function so that a matrix created with `click_pixels()` can be updated (#6).
* Moved support functions to utils.R.
* Simplified the README and added a blog badge.
* Bump to 0.1.0.

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
