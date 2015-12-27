library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Stock Performance by countries"),
  sidebarPanel(
    sliderInput('weeks', 'Number of Weeks: ',value = 1, min = 1, max = 24, step = 1,)
  ),
  mainPanel(
    plotOutput('myHist')
  )
))