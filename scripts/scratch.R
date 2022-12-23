# Testing ground for CPS budget data

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
library(readxl)

options(shiny.trace = TRUE)
setwd("~/GitHub/cps_budget_tool/origdata")


cpsfy1819 <- read_excel("fy2021bugetlines.xlsx")


covid <- read_csv("data/COVID-19_Outcomes_by_Vaccination_Status.csv",col_types = list(.default = col_character())) |>
  mutate(Date = as.Date(`Week End`, format = "%m/%d/%Y")) |>
  mutate_at(c(4:21), as.numeric) |>
  mutate("Vaccinated rate (per 10,000)" = round((`Outcome Vaccinated`/`Population Vaccinated`)*10000, 2),
         "Unvaccinated rate (per 10,000)" = round((`Outcome Unvaccinated`/`Population Unvaccinated`)*10000, 2),
         "Boosted rate (per 10,000)" = round((`Outcome Boosted`/`Population Boosted`)*10000, 2),
         # "Vaccinated (logged)" = log(`Outcome Vaccinated`),
         # "Unvaccinated (logged)" = log(`Outcome Unvaccinated`),
         # "Boosted (logged)" = log(`Outcome Boosted`),
         "Total" = `Population Vaccinated` + `Population Unvaccinated` + `Population Boosted`,
         "Percent boosted" = round((`Population Boosted`/Total),2)) |>
  group_by(Outcome,`Age Group`) |>
  arrange(Date) |>
  mutate("Cumulative Vaccinated" = cumsum(replace_na(`Outcome Vaccinated`,0)),
         "Cumulative Unvaccinated" = cumsum(replace_na(`Outcome Unvaccinated`,0)),
         "Cumulative Boosted" = cumsum(replace_na(`Outcome Boosted`,0)))
