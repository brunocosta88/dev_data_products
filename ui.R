#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(plotly)
library(shiny)
data(mtcars)
variables <- names(mtcars)

# Define UI for application that calculates a dynamic linear regression
shinyUI(fluidPage(

    # Application title
    titlePanel("Analysing MTCars Dataset"),

    # Sidebar 
    sidebarLayout(
        sidebarPanel(
           h1("MTCars Regression"),
           p("\n"),
           h4("Dynamic Calculation of Linear Regression using MTCars Dataset"),
           p("\n"),
           em("Choose one output variable:"),
           p("\n"),
           selectInput("output_var","Output variable", choices = variables),
           em("Choose one input variable (for x axis):"),
           p("\n"),
           selectInput("input_var1","Input (x axis)", choices = variables, selected = "wt"),
           em("Choose one or more input variable(s):"),
           p("\n"),
           checkboxGroupInput("input_var","Input variables", choices = variables, selected = "wt")
        ),

        # Show a plot of the lm
        mainPanel(
            plotlyOutput("distPlot"),
            h3("Selected variables for Prediction:"),
            textOutput("selected_var")
        )
    )
))
