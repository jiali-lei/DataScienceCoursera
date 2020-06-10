### Introduction

Imagine you are being asked to participate in a research experiment with the purpose of better understanding how people analyze data. The goal of the research is to study how income varies across different categories of college majors. 

### Data

<!-- -->

    install.packages("devtools")
    devtools::install_github("jhudsl/collegeIncome")
    library(collegeIncome)
    data(college)

Next download and install the matahari R package. Use the dance_start() and dance_save() to record the exploration conducted in the RStudio console.

<!-- -->

    devtools::install_github("jhudsl/matahari")
    library(matahari)
    
    # enter the following command before you start the analysis
    # to begin the documentation of your analysis
    dance_start(value = FALSE, contents = FALSE)
    
    # enter the following command when you have finished your analysis
    dance_save("~/Desktop/college_major_analysis.rds")


### Questions

- Is there an association between college major category and income?


