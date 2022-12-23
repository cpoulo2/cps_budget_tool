#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(shinythemes)
library(shinydashboard)
library(shinyBS)
library(htmltools)
library(DT)
library(leaflet)
require(scales)
library(plotly)
library(tidyverse)
library(ggthemes)

options(shiny.trace = TRUE)
 
cpsfy1819 <- read_excel("data/fy2021bugetlines.xlsx")

# Define the UI function for a education finance simulator template application 

shinyUI(fluidPage(
  
  titlePanel("CPS budget tool"),
  h5("Source: Chicago Public Schools, Interactive Budget"),
  
  # Sidebar with a slider input for number of bins
  
  mainPanel(
    tabsetPanel(
      tabPanel("Rates", plotlyOutput('plot', height = "700px", width = "1000px")),
      tabPanel("Weekly totals", plotlyOutput('plot2', height = "700px", width = "1000px")),
      tabPanel("Running total", plotlyOutput('plot3', height = "700px", width = "1000px")),
      tabPanel("Table",dataTableOutput("table")),
      
    )
  ),
  hr(),
  fluidRow(
    
    column(6,
           # sidebarLayout(

           selectizeInput("fundgrant",
                          label = "Select Fund Grant (ex. Student based budgeting)",
                          choices = unique(cpsfy1819$`Fund Grant Name`),
                          selected = "Student Based Budgeting"
                          
           ),),
    
    # column(6,
    #        dateRangeInput("daterange",
    #                       "Select a date range:",
    #                       start = "2021-04-03",
    #                       end = "2022-12-03",
    #                       min = "2021-04-03",
    #                       max = "2022-12-03",
    #                       format = "mm/dd/yy",
    #                       separator = " - "),
    ),
    # column(6,"."),
    column(6,
           selectizeInput("unit",
                          label = "Select a unit (ex. a school)",
                          choices = unique(cpsfy1819$`Unit Name`),
                          selected = "Education General - City Wide"
                          
           )
    ),
    column(6,
           helpText("Download a .csv of your current selections"),
           downloadButton(outputId = "download_data", 
                          label = "Download")
           
    ),
    column(width = 6)
    
    
    # Select Justices name here
    
    # selectizeInput("start",
    #                label = "Select a start date",
    #                choices = covid$`Week End`,
    #                selected = "12/25/2021"
    #                
    # ),
    
    # sliderInput("daterange",
    #             "Date range:",
    #             min = as.Date("2021-04-03","%Y-%m-%d"),
    #             max = as.Date("2022-12-03","%Y-%m-%d"),
    #             value=c(as.Date("2021-04-03"),as.Date("2022-12-03")),
    #             timeFormat="%m/%d/%Y"),
    # 
    # ),
    
    # ),
    
    
    
  )
)


