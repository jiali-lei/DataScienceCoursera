complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length l indicating the
        ## the location of the CSV files
        
        ## 'id' is an integer vector indicating the monitor ID numbers to 
        ## be used
        
        ## Return a data frame of the form:
        ## id   nobs
        ## 1    117
        ## 2    1041
        ## ...
        ## where 'id' is the monitor ID number
        ## and 'nobs' is the number of complete cases
        
        setwd(directory)
        
        ## read all the csv files in the directory
        temp <- list.files(pattern = "*.csv")
        myfiles <- lapply(temp, read.csv)
        
        nobsValue <- c()
        for (i in id) {
                nobsValue <- c(nobsValue, sum(complete.cases(myfiles[[i]])))
        }
        
        # set the directory where this .R file resides
        setwd("../")
        
        ## make a data frame with 'id' and 'nobs' as the column names
        data.frame("id" = id, "nobs" = nobsValue)
}
