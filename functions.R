evaluateDecoys <- function(score, decoy, pi0 = sum(decoy[!is.na(score)])/sum(!decoy[!is.na(score)]), title = 'PP plot of target PSMs' ,nBreaks=100){
  require("ggplot2")
  require("dplyr")
  require("grid")
  require("gridExtra")
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(1, 2)))

decoy <- decoy[!is.na(score)]
score <- score[!is.na(score)]

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

  if ((length(score[!decoy]) == 0) | (length(score[decoy]) == 0))
    return(p + annotate('text',decoy = 'NOT ENOUGH DATA TO PLOT',x = .5,y = .5))

  Ft <- ecdf(score[!decoy])
  Fd <- ecdf(score[decoy])
  x <- score[!decoy]
  df <- data_frame(Fdp = Fd(x), Ftp = Ft(x))

  ppPlot <- ppPlot + geom_point(data = df,aes(Fdp,Ftp),color = 'dark grey')

  data <- data_frame(score,decoy)
  histPlot <- ggplot(data, aes(score, fill = decoy, col=I("black")))+ geom_histogram(alpha = 0.5, binwidth=diff(range(score,na.rm=TRUE))/nBreaks, position = 'identity') +  labs(x = 'Score', y = 'Counts' ,title = 'Histogram of targets and decoys') +
    theme_bw() +
    theme(
      plot.title = element_text(size = rel(1.5)),
      axis.title = element_text(size = rel(1.2)),
      axis.text = element_text(size = rel(1.2)),
      axis.title.y = element_text(angle = 0))

  grid.arrange(ppPlot,histPlot,nrow=2)
}
