
# {pixeltrix}

<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
![Shiny
app](https://img.shields.io/badge/Shiny-not_yet-blue?style=flat&labelColor=white&logo=RStudio&logoColor=blue)
<!-- badges: end -->

An (aspirational) R package with a Shiny app that takes user input on a clickable grid and outputs a matrix object.

Basic premise is that the user:

1. Selects a grid size
2. Clicks pixels 'on' and 'off' (scope to expand beyond 1-bit and to use different symbols for the pixels)
3. Clicks a button to get a copyable (downloadable?) matrix (or vector, or something else) of the image

Tell me if this already exists. I know [privefl/pixelart](https://github.com/privefl/pixelart) takes an image as input, but I want the user to select squares interactively.

I want to do this for the lolz, like in [a previous blog post](https://www.rostrum.blog/2021/06/28/pixel-art/), but also to make my life easier for silly things like [{tamRgo}](https://github.com/matt-dray/tamRgo).
