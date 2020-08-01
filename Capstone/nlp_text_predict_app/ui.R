library(shiny)

# Define UI for application that ask for user-input of text and predict the next word
shinyUI(fluidPage(

    # Application title
    titlePanel("NLP Text Predictor"),
    h5("By Jiali L."),
    hr(),

    # paragraphs of instructions
    fluidRow(
        column(12,
            p("This is a NLP Text Predictive app, inspired by Swiftkey--a smart keyboard on phones."),
            p(" "),
            p("Just like texting on a smart phone, you can enter text in the input box."),
            p("The app will display 3 most probable options of the next word based on your input."),
            p("You can click on one of them if you see a match or just keep typing."),
            p(" "),
            p("The text predictive model is based on N-gram frequency and Katz Back-off Model."),
            p("The model is trained on a sample text corpus of English news, blogs, and tweets."),
            p(" "),
            p("NOTE: English only (for now).")),
        
        br(),
        
        column(12,
               align = "center",
               h4("Input Text (English Only)"),
               tags$textarea(id="text", rows=5, cols=60, ""),
               tags$head(tags$style(type="text/css", "#text {width: 70%}")))),
        
    hr(),
    
    fluidRow(
        column(12, align = "center", h4("Top Suggested Next Word")),
        column(4, align = "left", uiOutput("word1")),
        column(4, align = "center", uiOutput("word2")),
        column(4, align = "right", uiOutput("word3"))
    )
))
