

pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length l indicating the
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length l indicating the
        ## name of the pollutant for which we will calculate the mean;
        ## either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers to 
        ## be used
        
        ## Return the mean of the pollutant across all monitors list in
        ## the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!
        
        setwd(directory)
        
        ## read all the csv files in the directory
        temp <- list.files(pattern = "*.csv")
        myfiles <- lapply(temp, read.csv)
        
        ## combine the data specified by 'id' vertically (by rows)
        ## 'mysubfiles' is a data frame
        mysubfiles <- do.call(rbind, myfiles[c(id)])    
        ## or mysubfiles <- Reduce(rbind, myfiles[c(id)])
        
        # set the directory where this .R file resides
        setwd("../")
        
        mean(mysubfiles[[pollutant]], na.rm = TRUE)
}

complete2 <- function(directory, id = 1:332) {
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
        
        ## combine the data specified by 'id' vertically (by rows)
        ## 'mysubfiles' is a data frame
        mysubfiles <- Reduce(rbind, myfiles[c(id)])
        
        # set the directory where this .R file resides
        setwd("../")
        library(dplyr)
        mysubfiles %>% na.omit %>% group_by(ID) %>% summarise(nobs = n())
        
        ## This function, compared to the one in 'complete.R', sorts the id in ascending order by default
}