library(UsingR)
require(quantmod)
require(extrafont)
require(doBy)
require(PerformanceAnalytics)
require(ggplot2)

# Pre-Download Stock Data, this will take a few seconds.
countryNames<-read.csv("ETFCountries.txt")
tickerNames<-as.vector(countryNames[,2])
getSymbols(tickerNames, from="2012-01-01")

shinyServer(
  function(input, output) {
    output$myHist <- renderPlot({
      weeks <- input$weeks      
      weeksText <- paste0(weeks, " weeks")
      
      countriesprices <- list()
      for(i in 1:nrow(countryNames)) {
        countriesprices[[i]] <- Ad(get(tickerNames[i]))        
      }
      
      countriesprices <- do.call(cbind, countriesprices)
      ep<-endpoints(countriesprices, on = "weeks")
      countriesprices<-countriesprices[ep,]
      countriesprices<-Return.calculate(countriesprices)
      countriesprices<-last(countriesprices*100, weeksText)
      
      colnames(countriesprices) <- countryNames$Country
      countriespricest <- as.data.frame(t(countriesprices))
      names(countriespricest)[1] <- "Yield"
      names(countriespricest)[0] <- "Country"
      
      text<-paste0("Yield of the latest ",weeks, " week(s)")
      
      opts=theme(
        panel.background = element_rect(fill="darkolivegreen1"),
        panel.border = element_rect(colour="black", fill=NA),
        axis.line = element_line(size = 0.5, colour = "black"),
        axis.ticks = element_line(colour="black"),
        panel.grid.major = element_line(colour="white", linetype = 1),
        panel.grid.minor = element_blank(),
        axis.text.y = element_text(colour="black", size=20),
        axis.text.x = element_text(colour="black", size=20),
        text = element_text(size=25, family="xkcd"),
        legend.key = element_blank(),
        legend.background = element_blank(),
        plot.title = element_text(size = 40))
      
      mp<-barplot(countriespricest$Yield, names.arg=countriespricest$row.names, 
                  col = c("red", "green")[(countriespricest$Yield > 0)+1],
                  las=3,
                  ylim=c(floor(min(countriespricest$Yield)),
                         ceiling(max(countriespricest$Yield))))
      axis(1,at=mp,labels=countryNames[,1], las=2, srt = 45, adj= 1, xpd = TRUE)  
      mtext(text, side = 3)
    })
    
  }
)
