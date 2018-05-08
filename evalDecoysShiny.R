library(shiny)
library(markdown)
library(dplyr)
library(ggplot2)
library(mzID)

serverEvalDecoys = function(input, output, session) {
#######################
  ## read data from given path
  dataFlat <- reactive({flatten(mzID(req(input$file1$datapath)))})
  output$ColumnSelector <- renderUI({
	  tagList(
    selectInput("decoys","select the decoy column", choices = colnames(dataFlat())),

    selectInput("score","select the score column", choices = colnames(dataFlat())) )
  }
  )
  data <- reactive({
      data <- dataFlat()[,c(input$decoys,input$score)]
      data <- na.exclude(data)
      names(data)<-c("decoy","score")
      print(head(data))
      data$score<-as.double(data$score)
      if (input$log) data$score<--log10(data$score+1e-100)
      data
  })
  ## or read example data
  #exampledata = reactive({
  #  req(input$action)
  #  data.frame(x = rnorm(1000,1,2))
  #})

  #data_process = reactive({
  #  dt = exampledata()
  #  if (input$scale) {
  #    dt$x = scale(dt$x)
  #  }
  #  dt
  #})

  ## logic plot
#######################
  output$histPlot <- renderPlot({
	binwidth <- diff(range(data()$score,na.rm=TRUE))/input$nBreaks
	print(binwidth)
        ggplot(data(), aes(score, fill = decoy, col=I("black")))+ geom_histogram(alpha = 0.5, binwidth=binwidth, position = 'identity') +  labs(x = 'Score', y = 'Counts' ,title = 'Histogram of targets and decoys') +
    theme_bw() +
    theme(
      plot.title = element_text(size = rel(1.5)),
      axis.title = element_text(size = rel(1.2)),
      axis.text = element_text(size = rel(1.2)),
      axis.title.y = element_text(angle = 0))
  })
  output$ppPlot <- renderPlot({
	if (class(data()$decoy)=="logical"&class(data()$score)=="numeric"){
    pi0 <- sum(data()$decoy)/sum(!data()$decoy)
    ppPlot <- ggplot()  +
    geom_abline(slope = pi0,color = 'black') +
    labs(x = 'Decoy Percentile', y = 'Target\nPercentile' ,title = 'PP plot of target PSMs') +
    xlim(0,1) + ylim(0,1) +
    theme_bw() +
    theme(
      plot.title = element_text(size = rel(1.5)),
      axis.title = element_text(size = rel(1.2)),
      axis.text = element_text(size = rel(1.2)),
      axis.title.y = element_text(angle = 0))

  x <- data()$score[!data()$decoy]
  Ft <- ecdf(x)
  Fd <- ecdf(data()$score[data()$decoy])
  df <- data_frame(Fdp = Fd(x), Ftp = Ft(x))

  ppPlot + geom_point(data = df,aes(Fdp,Ftp),color = 'dark grey')
   }
  })

}


######################################################################################
uiEvalDecoys = function() fluidPage(
           sidebarLayout(
             sidebarPanel(width = 4,
                          HTML(markdownToHTML(text =
'
Import mzid file and assess decoy quality.
'
                          )), hr(),
                          fileInput ('file1',
                                     'Choose mzid File',
                                     accept = c('.mzid')
                          ),
                          checkboxInput("log", '-log10 transform score?', TRUE),
 			  numericInput("nBreaks", "# histogram bins:", 50, min = 1, max = 200),
                          HTML(markdownToHTML(text =
'')),
        uiOutput("ColumnSelector")
),
mainPanel(width = 8,  plotOutput('histPlot'),plotOutput('ppPlot'))
           ))

shinyApp(uiEvalDecoys, serverEvalDecoys)
