# Homework 2 Portfolio Assignment - Ballon d'Or Rankings Analysis

## 1. Project Overview
I chose to focus on a rankings dataset of the Ballon d'Or award, which has been given to the best men's soccer player in the world since 1956.
Soccer is one of my favorite sports and I wanted to do a deeper dive into the award that is given out the best player each year.

---

## 2. Interesting Facts Learned Through Visualization
- **Key Insights:**
  - I learned that a majority of votes are only given out to the top 5 players recieving votes
  - Discovered that most winners only recieve around 25-30% of the total votes
  - That some players like Messi and Cristiano Ronaldo have dominated the award for their country
  
- **Unexpected Finding:**
  - I learned that some countries that no longer exist have multiple award recipiants. Found this be quite interesting since I didn't really know the history of the award before the 2000s.

---

## 3. Interface Creation and Data Preparation
- **Data Sources and Preparation:**
  - I found my dataset [here](https://www.kaggle.com/datasets/mexwell/ballon-dor-voting-history)
  - The provided data had some missing data in the entries from 2010 to 2015 when FIFA paired with magazine *France Football* to combine the Ballon d'Or and FIFA Best Men's Player Awards
  - This discovery had me focus on points share by rank and wins by nationality since this was data available in all rows
  - The original dataset also only had ranking data up to 2018 so I had to self add the top 5 ranked players and their associated data from 2019 to 2023. 2020 is not included as the award was cancelled due to the COVID-19 pandemic

- **Interface Creation Process:**
  - I utilized basic Shiny tools to create an interface between some simple inputs and graphs
  - I used a simple option select to discern between the Ranks for the ridge plot showing the point distribution by rank.
  - I also utilized a slider inputs to filter years on the Winners by Country graph
  - I then had both inputs feed down to the data table show the specific data entries that were in each graph.

- **Style Customizations and Layout:**
  - I used basic themes to keep the design basic and less cluttered. I also used basic graphs to again simplify the data analysis.
  - There wasn't much influence on my design choices other than making it easy to ready and simple to code. I didn't want to "mess up" my graphs and convolute the data I was trying to show.

---

## 4. Reactive Graph Structure
- **Explanation of Reactive Graph:**
  - The user can provide 2 inputs: Rank selection (1-5) and Year selection (1956-2023)
  - The Rank selection filters the ridges shown on the ridge plot
  - The year will filter out the winners on the winners graph and show only the counts between the filtered years as well as only the corresponding values in the filtered years
  - Both of these valeus are then filtered down to the data table which will show only those values that correspond to the input values

- **Data-Driven Updates:**
  - The data shown is filtered down by the inputs quite simply by using a reactive element to create a data set that is used between the rank data and data table
  - Additionally, the winners data is filtered down by years at the same stage as the others

---

## 5. Conclusion
My Shiny App was a simple construction to show some interesting facts I discovered about the winenrs and top 5 ranked players in each year of the Ballon d'Or. I would like to improve the overall look of the app by going more in depth into themes and looking for addtional data to include. I also would like to inlcude more graph intereactivty but I struggled with getting the click events to work on the bar graph correctly, so I chose to leave them out so my graph would work as intended.

---

## 6. See link below for shinyapp.io
- [Shiny App](https://aaron-melcher.shinyapps.io/Ballon_dOr_Analysis/)

