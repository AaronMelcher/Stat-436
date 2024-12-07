library(tidyverse)
library(ggplot2)
library(DT)
library(ggridges)
library(shiny)
theme_set(theme_classic())

# Data setup - gathering sets and 
ballon_dor <- read_csv("BallonDOr.csv") |>
  filter(Rank <= 5) |>
  select(Year, Rank, Player, Club, Nationality, RankPts, Points, Share, Percent)

years <- pull(ballon_dor, Year) |>
  unique() |>
  na.omit()

ranks <- c(1, 2, 3, 4, 5)

winners <- ballon_dor |>
  group_by(Year) |>
  summarise(Winner = Player[Rank == 1],
            Total_Points = Points[Rank == 1],
            Nationality = Nationality[Rank == 1],
            Club = Club[Rank == 1],
            Rank_Points = RankPts[Rank == 1],
            Share = Share[Rank == 1],
            Percent = Percent[Rank == 1]
  ) |>
  arrange(Year)

### shiny app definition
ui <- fluidPage(
  titlePanel("Ballon d'Or Rankings Analysis"),
  p("Welcome to my Shiny App!"),
  p("This app explores some of the data associated with the Ballon d'Or Award for the best men's soccer player in the world."),
  p("The inputs below control the graph below them to show different data from the overall votes and winners respectively."),
  p("The data table at the bottom of the page will show the filtered results with all associated data."),
  fluidRow(
    column(6,
           h4("Select Ballon d'Or Rank (1-5):"),
           checkboxGroupInput("ranks", "Ranks", ranks, ranks, inline = TRUE)
    ),
    column(6,
           h4("Filter years (1956-2023):"),
           sliderInput("year", "Year", min = min(years), max = max(years), c(1956, 2023), sep = "")
    )
  ),
  fluidRow(
    column(6,
           plotOutput("rankDist")
    ),
    column(6,
           plotOutput("countryWins")
    )
  ),
  fluidRow(
    column(12,
           h4("Ballon D'Or Rankings Table"),
           dataTableOutput("playerTable")
    )
  )
)

server <- function(input, output) {
  rank_data <- reactive(
    ballon_dor |>
      filter(Rank %in% input$ranks,
             Year >= input$year[1],
             Year <= input$year[2]
      )
  )
  
  country_years <- reactive(
    winners |>
      filter(
        Year >= input$year[1],
        Year <= input$year[2]
      ) |>
      count(Nationality, name="Wins") |>
      arrange(desc(Wins))
  )
  
  output$rankDist <- renderPlot({
    ggplot(rank_data()) +
      geom_density_ridges(aes(Share, Rank, group = Rank), fill = "lightblue") +
      labs(x = "Points Share", y = "Rank", title = "Density of Points Share Won by Rank") +
      scale_y_discrete(limits = unique(rank_data()$Rank))
  })
  
  output$countryWins <- renderPlot({
    ggplot(country_years(), aes(reorder(Nationality, Wins), Wins, fill=Wins)) +
      geom_bar(stat = "identity") +
      coord_flip() +
      labs(
        title = "Number of Ballon D'Or Wins by Country ",
        x = "Country",
        y = "Number of Wins"
      )
  })
  
  output$playerTable <- renderDT(rank_data())
}

shinyApp(ui, server)

