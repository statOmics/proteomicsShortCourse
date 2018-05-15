maxFileSize=100
options(shiny.maxRequestSize=maxFileSize*1024^2)
source("~/App-evalDecoys/evalDecoysShiny.R")
shinyApp(uiEvalDecoys, serverEvalDecoys)
