# community-centers

<!-- badges: start -->

<!-- badges: end -->

This repository contains code and figures for our paper:

> Kenneth B. Vernon
> [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-0098-5092),
> and Scott Ortman
> [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-0709-5287)
> (2023). A method for defining dispersed community territories. *Journal of
> Archaeological Science*.

**Preprint**: [manuscript.pdf](/manuscript/manuscript.pdf)

**Supplement**: [/R/community-clustering.html](/R/community-clustering.html)

## Contents

📂 [\_extensions](/_extensions) has Quarto extension for compiling manuscript\
📂 [figures](/figures) contains all figures included in the paper\
📂 [manuscript](/manuscript) contains the pre-print\
  ⊢ 📄 [manuscript.qmd](/manuscript/manuscript.qmd)\
  ⊢ 📄 [manuscript.pdf](/manuscript/manuscript.pdf)\
  ⊢ 📄 [jas-reviews.md](/manuscript/jas-reviews.md)\
  ⊢ 📄 [jas-reviews-response.md](/manuscript/jas-reviews-response.md)\
📂 [R](/R) code for preparing data and conducting analysis, including\
  ⊢ 📄 [community-clustering.qmd](/R/analysis.qmd) is the primary analysis and\
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

## License

**Text and figures:** [CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)

**Code:** [MIT](LICENSE.md)

**Data:** not available.
