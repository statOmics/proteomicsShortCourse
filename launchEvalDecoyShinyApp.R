maxFileSize=100
options(shiny.maxRequestSize=maxFileSize*1024^2)
options(shiny.launch.browser = .rs.invokeShinyWindowExternal)
source("~/App-evalDecoys/evalDecoysShiny.R")
shinyApp(uiEvalDecoys, serverEvalDecoys)
