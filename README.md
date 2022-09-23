
# {pixeltrix}

<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R-CMD-check](https://github.com/matt-dray/tamRgo/workflows/R-CMD-check/badge.svg)](https://github.com/matt-dray/tamRgo/actions)
[![Codecov test coverage](https://codecov.io/gh/matt-dray/pixeltrix/branch/main/graph/badge.svg)](https://app.codecov.io/gh/matt-dray/pixeltrix?branch=main)
<!-- badges: end -->

A simple R package for interactive pixel art in the plot window that returns a matrix.

## Install

You can install it [from GitHub](https://github.com/matt-dray/pixeltrix):

``` r
install.packages("remotes")  # if not yet installed
remotes::install_github("matt-dray/pixeltrix")
```

It's made entirely with base R. Graphics with `image()`, interactive plot-point selection with `locator()`. Wrapped up in a `repeat` loop.

## How

Begin an interactive plot with `click_pixels()`. You can set the number of rows and columns of pixels in the plot, set the number of pixel states (defaults to binary) and choose to turn off the grid overlay.

Click individual pixels in the plot to cycle through their states (lightest to darkest). If `n_states = 2` (default), then the pixels are 'off' (0, white) or 'on' (1, grey). 

Press <kbd>Esc</kbd> when you're done. A matrix is returned that encodes your pixel art.

## Binary example

Here's a 1-bit original kuchipatchi sprite from [the original Tamagotchi](https://en.wikipedia.org/wiki/Tamagotchi).

``` r
click_pixels(n_row = 14, n_col = 14) -> m1
```

<img src="man/figures/kuchipatchi.png" alt="A 14 by 14 pixel grid with a two-toned sprite of a pet character from the original 90s Tamagotchi pets.">

``` r
m1
#       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14]
#  [1,]    0    0    0    0    1    1    1    1    1     1     0     0     0     0
#  [2,]    0    0    0    1    0    0    0    0    0     0     1     0     0     0
#  [3,]    0    1    1    0    1    0    0    0    0     1     0     1     0     0
#  [4,]    1    0    0    0    0    0    0    0    0     0     0     0     1     0
#  [5,]    0    1    1    1    0    0    0    0    0     0     0     0     1     0
#  [6,]    1    0    0    0    0    0    0    0    0     0     0     0     1     0
#  [7,]    0    1    1    1    0    0    0    0    0     0     0     0     1     0
#  [8,]    0    0    0    1    0    0    0    0    1     0     1     0     0     1
#  [9,]    0    0    0    1    0    0    0    0    1     0     1     0     0     1
# [10,]    0    0    0    1    0    0    0    0    0     1     0     0     0     1
# [11,]    0    0    0    0    1    0    0    0    0     0     0     0     1     0
# [12,]    0    0    0    0    0    1    0    1    1     1     0     1     0     0
# [13,]    0    0    0    0    0    1    0    1    0     1     0     1     0     0
# [14,]    0    0    0    0    0    0    1    0    0     0     1     0     0     0
```

## Three-tone example

Here's the player character from [the first generation of Pokémon games](https://en.wikipedia.org/wiki/Pok%C3%A9mon_Red_and_Blue) on the Game Boy. It uses three states: 0 for white, 1 for light grey, 2 for dark grey.

``` r
click_pixels(14, 16, n_states = 3) -> m2
```

<img src="man/figures/ash.png" alt="A 14 by 16 pixel grid with a three-toned sprite of the main character from the first generation of Pokemon games for the Game Boy.">

``` r
m2
#       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14]
#  [1,]    0    0    0    0    2    2    2    2    2     2     0     0     0     0
#  [2,]    0    0    0    2    1    1    1    1    1     1     2     0     0     0
#  [3,]    0    0    2    1    1    1    1    1    1     1     1     2     0     0
#  [4,]    0    0    2    1    1    1    1    1    1     1     1     2     0     0
#  [5,]    0    2    2    2    1    0    0    0    0     1     2     2     2     0
#  [6,]    0    2    2    0    2    2    2    2    2     2     0     2     2     0
#  [7,]    2    0    2    0    0    0    0    0    0     0     0     2     0     2
#  [8,]    2    0    0    0    0    2    0    0    2     0     0     0     0     2
#  [9,]    0    2    2    0    0    2    0    0    2     0     0     2     2     0
# [10,]    0    2    2    2    0    0    1    1    0     0     2     2     2     0
# [11,]    2    0    0    2    2    2    2    2    2     2     2     0     0     2
# [12,]    2    0    0    2    2    2    2    2    2     2     2     0     0     2
# [13,]    0    2    2    2    1    1    2    2    1     1     2     2     2     0
# [14,]    0    0    2    1    2    2    1    1    2     2     1     2     0     0
# [15,]    0    0    2    1    1    1    2    2    1     1     1     2     0     0
# [16,]    0    0    0    2    2    2    0    0    2     2     2     0     0     0
```
