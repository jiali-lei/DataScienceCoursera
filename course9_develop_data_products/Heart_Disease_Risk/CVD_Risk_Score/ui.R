#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that calculates the 10-year risk score of CVD
shinyUI(fluidPage(

    # Application title
    titlePanel("Heart Disease Risk Calculator"),

    # Sidebar with a slider input, radio button selection, and text input for calculation
    sidebarLayout(
        sidebarPanel(
            radioButtons("gender", "Gender:", choices=c("F", "M"), selected="F"),
            sliderInput("age", "Age (years):", 21, 80, value=30),
            sliderInput("sbp", "Systolic Blood Pressure (mmHg):", 80, 160, value=125),
            radioButtons("tbp", "Treatment for Hypertention:", choices=c("Yes", "No"), selected="No"),
            radioButtons("smoker", "Current Smoker:", choices=c("Yes", "No"), selected="No"),
            radioButtons("diabetes", "Diabetes:", choices=c("Yes", "No"), selected="No"),
            textInput("hdl", "HDL:", value=45),
            textInput("tch", "Total Cholesterol", value=180),
            submitButton("Submit")
        ),

        # Show a plot of risk scores and calculated results
        mainPanel(
            plotOutput("plot1"),
            h5("(Note: This risk assessment tool predicts your risk of developing a heart attack or death from coronary disease in the next 10 years.)"),
            h3("Your 10-year Heart Disease Risk:"),
            textOutput("risk_score"),
            h3("Your Heart/Vascular Age:"),
            textOutput("heart_age"),
            h4("Reference"),
            h5(tags$a(href="https://www.ahajournals.org/doi/10.1161/CIRCULATIONAHA.107.699579", 
                      "[1] D’agostino RB, Vasan RS, Pencina MJ, Wolf PA, Cobain M, Massaro JM, Kannel WB. General cardiovascular risk profile for use in primary care. Circulation. 2008 Feb 12;117:743-53. PMID:18212285.")),
            h5(tags$a(href="https://framinghamheartstudy.org/fhs-risk-functions/cardiovascular-disease-10-year-risk/#",
                      "[2] Framingham Heart Study"))
        )
    )
))
