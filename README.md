---
title: "Developing Data Products"
author: "Daniel Sobrado"
date: "Sunday, May 24, 2015"
output: html_document
---

## Project in Developing Data Products
###  Stock market performance in the last days
####  - a Slidify presentation incorporating a Shiny app to show interactively the stock market performance of the last X days. 


####This presentation is designed to show the change in stock market values in the last X days.It consisted of 4 parts.  

- Retrieve stock market data from yahoo finance using the package quantmod   
- Calculation of yields using the package PerformanceAnalytics
- Interactive report(including a Shiny interactive report)  
- Conclusion  
  
####Shiny and Shiny app, which are main part of this presentation, enable to make report using R interactive and to distribute it on the Web.  
####Slidify together with gh-pages enable Web slide of the report incorporating Shiny app.  

####Togther with R markdown file of Slidify and R cource code of Shiny(see howtouse tab in Shiny app on page 5), this presentation provides an explanatory report.  

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
