corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length l indicating the
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length l indicating the number
        ## of completely observed observations (on all variables) required
        ## to compute the correlation between nitrate and sulfate;
        ## the default is 0
        
        ## Return a numeric vector of correlation
        ## NOTE: Do not round the result!
        
        ## read in all the csv files and combine them into one file by rows
        setwd(directory)
        temp <- list.files(pattern = "*.csv")
        myfiles <- lapply(temp, read.csv)
        # set the directory where this .R file resides
        setwd("../")
        
        myfiles_comp <- Reduce(rbind, myfiles)
        
        ## run 'complete' function to get the output data frame
        data_comp <- complete(directory)
        
        library(dplyr)
        ## extract monitor ID from 'complete' output where it meets threshold
        aboveThres <- subset(data_comp, data_comp$nobs > threshold, "id")
        aboveThres_ID <- aboveThres[[1]] ## get vector out of a list
        myfiles_aboveThres <- subset(myfiles_comp, myfiles_comp$ID %in% aboveThres_ID)
        myfiles_aboveThres %>% na.omit %>% group_by(ID) %>% summarise(correlation = cor(sulfate, nitrate))
        
        ## the output is in data frame with 2 columns
        ## can assign the output to a variable, and extract the 2nd columns as a vector output
}