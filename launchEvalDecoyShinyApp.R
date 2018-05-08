maxFileSize=100
options(shiny.maxRequestSize=maxFileSize*1024^2)
source("evalDecoysShiny.R")
shinyApp(uiEvalDecoys, serverEvalDecoys)
