# community-centers

<!-- badges: start -->
[![DOI](https://zenodo.org/badge/644078765.svg)](https://zenodo.org/doi/10.5281/zenodo.11661269)
<!-- badges: end -->

This repository contains code and figures for our paper:

> Kenneth B. Vernon
> [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-0098-5092),
> and Scott Ortman
> [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-0709-5287)
> (2024). A method for defining dispersed community territories. *Journal of
> Archaeological Science*.

**Preprint**: [manuscript.pdf](/manuscript/manuscript.pdf)

**Supplement**:
[community-clustering.html](https://kbvernon.github.io/community-centers/R/community-clustering.html)

## Contents

📂 [\_extensions](/_extensions) has Quarto extension for compiling manuscript\
📂 [figures](/figures) contains all figures included in the paper\
📂 [manuscript](/manuscript) contains the pre-print\
  ⊢ 📄 [bibliography.bib](/manuscript/bibliography.bib)\
  ⊢ 📄 [manuscript.qmd](/manuscript/manuscript.qmd)\
  ⊢ 📄 [manuscript.pdf](/manuscript/manuscript.pdf)\
  ⊢ 📄 [jas-reviews.md](/manuscript/jas-reviews.md)\
  ⊢ 📄 [jas-reviews-response.md](/manuscript/jas-reviews-response.md)\
📂 [R](/R) code for preparing data and conducting analysis, including\
  ⊢ 📄 [community-clustering.qmd](/R/community-clustering.qmd) is the primary
analysis and\
  ⊢ 📄 [get-elevation.R](/R/get-elevation.R) downloads DEMs.\
  ⊢ 📄 [labeled-overview-map.R](/R/labeled-overview-map.R) make overview map
with labeled landmarks, administrative units, and cities.

## 💾 Data availability

Unfortunately, the locations of archaeological sites in the US count as
sensitive data, so we cannot simply share them here. If you would like to use
any of these data, you will need to get permission from the State Historic
Preservation Offices in Colorado, New Mexico, and Arizona.

For what's it worth, you can still explore these data (with jittered locations)
using the [cyberSW](https://cybersw.org/) web app.

## 📈 Replicate analysis

Assuming you had access to the data in `community-centers.gpkg`, you could
re-run all of the data preparation and analysis like this:

``` r
library(here)
library(quarto)

# needs to be run in this order
here("R", "get-elevation.R") |> source()
here("R", "labeled-overview-map.R") |> source()
here("R", "community-clustering.qmd") |> quarto_render()

# if you have a hankerin' to compile the manuscript
# you can do that like so:
here("manuscript", "manuscript.qmd") |> quarto_render()
```

## License

**Text and figures:** [CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)

**Code:** [MIT](LICENSE.md)

**Data:** not available.
