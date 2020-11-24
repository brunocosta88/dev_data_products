#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlotly({
        
        data("mtcars")
        
        #x <- select(mtcars,input$input_var)
        #y <- select(mtcars,input$output_var)
        
        x <- input$input_var
        x_axis <- input$input_var1
        y <- input$output_var
        
        #print(x)
        #print(y)
    
            x1 <- paste(x, collapse = " + ")
            y1 <- paste("~",y)
           
            if (x_axis %in% x) form <- paste(y," ~ ", x1 )
            else if (length(x > 0)) form <- paste(y," ~ ", x_axis, " + ", x1 )
            else form <- paste(y," ~ ", x_axis)
            
            #print(form)
            
            fit <- lm(form, data = mtcars)
            #print(summary(fit))
            #q <- qplot(x =  mtcars[[x_axis]],  y = mtcars[[y]], xlab = x_axis, ylab = y)
            #q <- q + geom_abline(intercept = coef(fit)[1], slope = coef(fit)[x_axis], color="red")
            #q
            
            p <- mtcars %>% 
                plot_ly(x = ~mtcars[[x_axis]]) %>%
                add_markers( y = ~mtcars[[y]]) %>%
                add_lines(x = ~mtcars[[x_axis]], y = fitted(fit), color = "red", text = "regression line")
            
            f <- list(
                family = "Courier New, monospace",
                size = 18
            )
            xax <- list(
                title = x_axis,
                titlefont = f
            )
            yax <- list(
                title = y,
                titlefont = f
            )
                
            p <- p %>% layout(xaxis = xax, yaxis = yax)
            p
           
    })
    
    output$selected_var <- renderText({ 
        x <- input$input_var
        x_axis <- input$input_var1
        
        if (x_axis %in% x)  x1 <- paste(x, collapse = " + ")
        else  x1 <- paste(c(x_axis,x), collapse = " + ")
    })
    
})
