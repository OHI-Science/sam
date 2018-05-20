## calculate_scores.R

## This script calculates OHI scores with the `ohicore` package.
## - The `ohicore` function CalculateAll() calculates OHI scores.

## set working directory for all OHI calculations
setwd("~/github/sam/toolbox-demo")

## load required packages after checking if they are already installed
# packages_required  <- c('ohicore', 'tidyverse', 'stringr', 'zoo')
# packages_check     <- packages_required[!packages_required %in% (.packages())]
# if(length(packages_check)) install.packages(packages_check)
# packages_installed <- sapply(packages_required, FUN = function(x) library(x, character.only = TRUE))


## load scenario configuration
conf = ohicore::Conf('conf')

## check that scenario layers files
ohicore::CheckLayers('layers.csv', 'layers', flds_id=conf$config$layers_id_fields)

## load scenario layers for ohicore to access.
layers = ohicore::Layers('layers.csv', 'layers')

## select corresponding data year to use for pressures and resilience
scenario_years <- 2017
layers$data$scenario_year <- scenario_years


## calculate scenario scores
scores <- ohicore::CalculateAll(conf, layers)

## save scores as scores.csv
readr::write_csv(scores, 'scores.csv', na='')

## visualize ----

# visualize scores ----

## Flower plots for each region ----
source('plot_flower_local.R')

##  plot.
PlotFlower(region_plot = rgn_id_sam,
  assessment_name = "Samoa")

