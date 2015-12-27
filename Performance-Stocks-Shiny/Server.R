library(UsingR)
require(quantmod)
require(extrafont)
require(doBy)
require(PerformanceAnalytics)
require(ggplot2)

shinyServer(
  function(input, output) {
    output$myHist <- renderPlot({
      weeks <- input$weeks
      
      weeksText <- paste0(weeks, " weeks")

      countryNames<-read.csv("ETFCountries.txt")
      
      countriesprices <- list()
      for(i in 1:nrow(countryNames)) {
        fileName<-paste0("Countries/", countryNames$Ticker[i], ".csv")
        fileZoo<-as.xts(read.zoo(fileName, sep = ",", header = TRUE, stringsAsFactors=FALSE, format = "%Y-%m-%d"))
        ep<-endpoints(fileZoo, on = "weeks")
        fileZoo<-fileZoo[ep,]
        fileZoo<-Return.calculate(fileZoo)
        countriesprices[[i]] <- last(fileZoo[,grep("Close", colnames(fileZoo), ignore.case = TRUE)]*100, weeksText)
      }
      
      countriesprices <- do.call(cbind, countriesprices)
      colnames(countriesprices) <- countryNames$Pais
      countriespricest <- as.data.frame(t(countriesprices))
      names(countriespricest)[1] <- "Rentabilidad"
      names(countriespricest)[0] <- "Pais"
      
      text<-paste0("Yield of the latest ",weeks, " week(s)")
      
      #countriespricest <- orderBy(~-z+b, data=dd)(countriespricest,desc(Rentabilidad))
      #countriespriceordered<-countriespricest[,with(countriespricest, order(1))]
      
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
      
      mp<-barplot(countriespricest$Rentabilidad, names.arg=countriespricest$row.names, 
                  col = c("red", "green")[(countriespricest$Rentabilidad > 0)+1],
                  las=3,
                  ylim=c(floor(min(countriespricest$Rentabilidad)),
                         ceiling(max(countriespricest$Rentabilidad))))
      axis(1,at=mp,labels=countryNames$Pais, las=2, srt = 45, adj= 1, xpd = TRUE)  
      mtext(text, side = 3)
    })
    
  }
)
