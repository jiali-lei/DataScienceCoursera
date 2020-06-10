#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(pracma)

# Define server logic required to calculate CVD risk score
shinyServer(function(input, output) {

    # create column names for the data frame used in calculation
    cnames <- c("b_age", "b_total_cholesteral", "b_HDL", 
                "b_SBP_treat", "b_SBP_noTreat",
                "b_smoke", "b_diabetes")
    # create coefficient vectors
    m_coeff <- c(3.06117, 1.12370, -0.93263,
                 1.93303, 1.99881,
                 0.65451, 0.57367)
    f_coeff <- c(2.32888, 1.20904, -0.70833,
                 2.76157, 2.82263,
                 0.52873, 0.69154)
    # 10-year survival baseline value
    m_So10 <- 0.88936
    f_So10 <- 0.95012
    
    genderInput <- reactive({
        input$gender
    })
    
    tchInput <- reactive({
        as.numeric(input$tch)
    })
    
    input_values <- reactive({    
        # gather input values
        ageInput <- as.numeric(input$age)
        tchInput <- as.numeric(input$tch)
        hdlInput <- as.numeric(input$hdl)
        sbpInput <- as.numeric(input$sbp)
        tbp <- ifelse(input$tbp=="No", sbpInput, exp(0))
        tbp_no <- ifelse(input$tbp=="No", exp(0), sbpInput)
        smokerInput <- ifelse(input$smoker=="No", 0, 1)
        diabetesInput <- ifelse(input$diabetes=="No", 0, 1)
        
        # create vectors with input values
        c(log(ageInput), log(tchInput), log(hdlInput),
          log(tbp), log(tbp_no),
          smokerInput, diabetesInput)
    })
    
    # a function to calculate CVD risk score
    r_s <- reactive({
        ifelse(genderInput()=="F",
               1 - f_So10^(exp(f_coeff %*% input_values() - 26.1931)),
               1 - m_So10^(exp(m_coeff %*% input_values() - 23.9802)))
    })
    
    # data frame of risk score and heart age
    f_df <- data.frame(risk_score = c(1.2, 1.5, 1.7, 2.0, 2.4, 2.8,
                                      3.3, 3.9, 4.5, 5.3, 6.3, 7.3,
                                      8.6, 10.0, 11.7, 13.7),
                       heart_age = c(30, 31, 34, 36, 39, 42,
                                     45, 48, 51, 55, 59, 64,
                                     68, 73, 79, 80))
    m_df <- data.frame(risk_score = c(1.6, 1.9, 2.3, 2.8, 3.3, 3.9,
                                      4.7, 5.6, 6.7, 7.9, 9.4, 11.2,
                                      13.2, 15.6, 18.4, 21.6, 25.3, 29.4),
                       heart_age = c(30, 32, 34, 36, 38, 40,
                                     42, 45, 48, 51, 54, 57, 
                                     60, 64, 68, 72, 76, 80))
    
    # fit a linear model between risk_score and heart_age for gender
    h_age <- reactive({
        if (genderInput()=="F"){
            modelF <- lm(heart_age ~ poly(risk_score,3), data=f_df)
            predict(modelF, newdata=data.frame(risk_score=r_s()*100))
        }
        else {
            modelM <- lm(heart_age ~ poly(risk_score,3), data=m_df)
            predict(modelM, newdata=data.frame(risk_score=r_s()*100))
        }
    })
    
    
    output$plot1 <- renderPlot({
        # construct the data frame for the plot
        # risk_score vs total_cholesteral holding all other variable constant
        tch_range <- 120:280
        input_df <- as.data.frame(matrix(rep(input_values(), length(tch_range)),
                                         nrow=length(tch_range),
                                         byrow=TRUE))
        colnames(input_df) <- cnames
        input_df$b_total_cholesteral <- log(tch_range)
        calcRS <- function(x) {
            ifelse(genderInput()=="F",
                   100*(1 - f_So10^(exp(f_coeff %*% x - 26.1931))),
                   100*(1 - m_So10^(exp(m_coeff %*% x - 23.9802))))
        }
        risk_score <- apply(input_df, 1, calcRS)
        plot(tch_range, risk_score, type="l", lwd=2,
             main = "Risk Score vs Total Cholesteral Level",
             sub = "(Note: holding all other inputs constant)",
             xlab = "Total Cholesteral",
             ylab = "10-Year Heart Disease Risk Score (%)")
        points(tchInput(), r_s()*100, cex = 2, col = "red")
        abline(h=r_s()*100, v=tchInput(), lty=2, col="red")
        text(tchInput(), r_s()*100, "Your Risk Score", col = "red", adj = c(-0.1, 1.5))
        
    })
    
    output$risk_score <- renderText({
        paste(round(r_s()*100, 2), "%")
    })
    
    output$heart_age <- renderText({
        round(h_age())
    })

})
