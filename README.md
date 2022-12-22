
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pixeltrix

<!-- badges: start -->

[![Project Status: Concept – Minimal or no implementation has been done
yet, or the repository is only intended to be a limited example, demo,
or
proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R-CMD-check](https://github.com/matt-dray/tamRgo/workflows/R-CMD-check/badge.svg)](https://github.com/matt-dray/tamRgo/actions)
[![Codecov test
coverage](https://codecov.io/gh/matt-dray/pixeltrix/branch/main/graph/badge.svg)](https://app.codecov.io/gh/matt-dray/pixeltrix?branch=main)
[![Blog
posts](https://img.shields.io/badge/rostrum.blog-posts-008900?labelColor=000000&logo=data%3Aimage%2Fgif%3Bbase64%2CR0lGODlhEAAQAPEAAAAAABWCBAAAAAAAACH5BAlkAAIAIf8LTkVUU0NBUEUyLjADAQAAACwAAAAAEAAQAAAC55QkISIiEoQQQgghRBBCiCAIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAAh%2BQQJZAACACwAAAAAEAAQAAAC55QkIiESIoQQQgghhAhCBCEIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAA7)](https://www.rostrum.blog/tags/pixeltrix/)
<!-- badges: end -->

A simple R package that lets you select ‘pixels’ interactively from a
plot window and returns your final image as a matrix, or a list of
matrices that can be converted to a gif.

## How to

You can install {pixeltrix} [from
GitHub](https://github.com/matt-dray/pixeltrix). It has no dependencies
unless you want to make gifs, which requires you to install
[{gifski}](https://cloud.r-project.org/web/packages/gifski/index.html).

``` r
install.packages("remotes")  # if not yet installed
remotes::install_github("matt-dray/pixeltrix")
library(pixeltrix)
```

Basic use:

1.  Use `click_pixels()` to begin an interactive, clickable plot of
    squares (‘pixels’).
2.  Click individual pixels repetitively to cycle through their states.
3.  Press the <kbd>Esc</kbd> key when you’re done, or the ‘Finish’
    button in RStudio’s plot window, to return a matrix that encodes
    your image.

You can also:

- pass a matrix output from `click_pixels()` to `edit_pixels()` and make
  changes
- draw your matrix to the plotting window as an image with
  `draw_pixels()`
- create a list of animation ‘frames’ with `frame_pixels()` and write
  them to a gif with `gif_pixels()`

## Examples

### Sprite

Let’s create a sprite of the player character from *Pokémon* (1996)
using `click_pixels()`:

``` r
pkmn_sprite <- click_pixels(
  n_rows   = 16,
  n_cols   = 14,
  n_states = 3,
  colours  = c("white", "#879afb", "grey20")  # Pokémon Blue palette
)
# Click squares in the plot window. Press <Esc> to end.
```

This opens an interactive plot window. You can click to cycle the pixels
through each of the three states. Here’s how that looks in RStudio:

<img src="man/figures/pkmn-rstudio.png" alt="An RStudio window. The console has run the function click_pixels(blue) and has printed the message 'click squares in the plot window, press Esc to end.' In the plot pane is a 16 by 14 pixel grid with a sprite of the main character from the first generation of Pokemon games for the Game Boy. The background is white, the outlines are dark grey and the highlights are light blue There's a black grid around the pixels." width="50%">

A matrix is returned when you’ve finished clicking and pressed
<kbd>Esc</kbd>. Note that the colour palette is stored in the `colours`
attribute, where the name of each element corresponds to its pixel state
value in the matrix.

``` r
str(pkmn_sprite)
#  int [1:16, 1:14] 0 0 0 0 0 0 2 2 0 0 ...
#  - attr(*, "colours")= Named chr [1:3] "white" "#879afb" "grey20"
#   ..- attr(*, "names")= chr [1:3] "0" "1" "2"
```

You can pass the matrix to `edit_pixels()` to reopen the editor and make
adjustments. The `draw_pixels()` function simply plots your matrix,
optionally with a new colour palette:

``` r
draw_pixels(
  m = pkmn_sprite,
  colours = c("#9bbc0f", "#8bac0f", "#306230")  # Game Boy palette
)
```

<img src="man/figures/pkmn.png" alt="A 14 by 16 pixel grid with a sprite of the main character from the first generation of Pokemon games for the Game Boy. It's coloured using the green shades of the original Game Boy." width="33%">

### Animation

You can create multiple animation frames with `frame_pixels()`. The
prior frame is used as a template for the next. Here’s how it might look
to recreate Mario’s walk cycle from *Super Mario Brothers* (1983):

``` r
mario_frames <- frame_pixels(
  n_rows   = 16,
  n_cols   = 16,
  n_states = 4,
  colours  = c("#8861FE", "#F6B95B", "#EF151A", "#7F6D14")
)
# Click squares in the plot window. Press <Esc> to end.
# Add a frame? y/n: y
# Click squares in the plot window. Press <Esc> to end.
# Current frame count: 2
# Add a frame? y/n: y
# Click squares in the plot window. Press <Esc> to end.
# Current frame count: 3
# Add a frame? y/n: n
# Final frame count: 3
```

The structure of the object is a list of matrices, where each matrix is
a frame of the animation.

``` r
str(mario_frames)
# List of 3
#  $ : int [1:16, 1:16] 0 0 0 0 0 0 0 0 1 1 ...
#   ..- attr(*, "colours")= Named chr [1:4] "#8861FE" "#F6B95B" "#EF151A" "#7F6D14"
#   .. ..- attr(*, "names")= chr [1:4] "0" "1" "2" "3"
#  $ : int [1:16, 1:16] 0 0 0 0 0 0 0 0 0 0 ...
#   ..- attr(*, "colours")= Named chr [1:4] "#8861FE" "#F6B95B" "#EF151A" "#7F6D14"
#   .. ..- attr(*, "names")= chr [1:4] "0" "1" "2" "3"
#  $ : int [1:16, 1:16] 0 0 0 0 0 0 0 0 0 0 ...
#   ..- attr(*, "colours")= Named chr [1:4] "#8861FE" "#F6B95B" "#EF151A" "#7F6D14"
#   .. ..- attr(*, "names")= chr [1:4] "0" "1" "2" "3"
```

You can then convert the frames to a gif with `gif_pixels()`.

``` r
gif_pixels(
  frames  = mario_frames, 
  colours = super_colours,
  file    = "super-mario.gif", 
  delay   = 0.15  # passed to gifski::save_gif()
)
# Inserting image 3 at 0.30s (100%)...
# Encoding to gif... done!
# [1] "super-mario.gif"
```

<img src="man/figures/mario.gif" alt="An animated 16 by 16 pixel grid with a coloured sprite of Mario from the original Super Mario Bros for the NES. There are three frames that each show a step in Mario's walk cycle." width="33%">
