maxFileSize=100
options(shiny.maxRequestSize=maxFileSize*1024^2)
source("~/App-MSqRob/combineFeatures.R")
shiny::runApp("~/App-MSqRob/")
