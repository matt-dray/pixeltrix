
# {pixeltrix}

<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R-CMD-check](https://github.com/matt-dray/tamRgo/workflows/R-CMD-check/badge.svg)](https://github.com/matt-dray/tamRgo/actions)
[![Codecov test coverage](https://codecov.io/gh/matt-dray/pixeltrix/branch/main/graph/badge.svg)](https://app.codecov.io/gh/matt-dray/pixeltrix?branch=main)
[![Blog post](https://img.shields.io/badge/rostrum.blog-post-008900?labelColor=000000&logo=data%3Aimage%2Fgif%3Bbase64%2CR0lGODlhEAAQAPEAAAAAABWCBAAAAAAAACH5BAlkAAIAIf8LTkVUU0NBUEUyLjADAQAAACwAAAAAEAAQAAAC55QkISIiEoQQQgghRBBCiCAIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAAh%2BQQJZAACACwAAAAAEAAQAAAC55QkIiESIoQQQgghhAhCBCEIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAA7)](https://www.rostrum.blog/2022/09/24/pixeltrix/)
<!-- badges: end -->

A simple R package that lets you select ‘pixels’ interactively from a plot window and returns your final image as a matrix

## How to

You can install {pixeltrix} [from GitHub](https://github.com/matt-dray/pixeltrix). There are no dependencies.

``` r
install.packages("remotes")  # if not yet installed
remotes::install_github("matt-dray/pixeltrix")
library(pixeltrix)
```

To use:

1. Begin an interactive plot with `click_pixels()`. You can set the dimensions, the number of clickable 'states' and whether to use a grid overlay.
2. Click pixels in the plot to cycle through their states (higher values are darker).
3. Press the <kbd>Esc</kbd> key when you're done, or the 'Finish' button in RStudio's plot window. A matrix is returned that encodes your image.

You can supply the matrix output from `click_pixels()` into `edit_pixels()` in order to make changes.

You can draw your matrix to a plotting window with `draw_pixels()`.

## Examples

### Tamagotchi

``` r
click_pixels(n_row = 14, n_col = 14) -> tam_sprite
```

<img src="man/figures/kuchipatchi.png" alt="A 14 by 14 pixel grid with a two-toned sprite of a pet character from the original 90s Tamagotchi pets.">

<details><summary>Click to expand the output matrix.</summary>

``` r
tam_sprite
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

</details>

### Pokémon

``` r
click_pixels(14, 16, n_states = 3) -> poke_sprite
```

<img src="man/figures/ash.png" alt="A 14 by 16 pixel grid with a three-toned sprite of the main character from the first generation of Pokemon games for the Game Boy.">

<details><summary>Click to expand the output matrix.</summary>

``` r
poke_sprite
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

</details>
