#libs
if (!require("pacman")) {
  install.packages("pacman")
  library("pacman")
}
suppressPackageStartupMessages(pacman::p_load(devtools, roxygen2, stringr, testthat))
options(digits = 2, scipen = 2)

#make documentation
suppressPackageStartupMessages(document())

#install
#for some weird reason this sometimes begins reinstalling packages for no reason I can find
install("../test.package/", dependencies = F)

#load
suppressPackageStartupMessages(pacman::p_load(test.package, testthat))

