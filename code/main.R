# packages ----------------------------------------------------------------
require(tidyverse)
require(httr)
require(XML)
require(RJSONIO)


# data --------------------------------------------------------------------
source("./code/download_school_data.R")
source("./code/load_school_data.R")
# source("./code/scrape_geo.R")

write_csv(schools, "./data/datafile.csv")