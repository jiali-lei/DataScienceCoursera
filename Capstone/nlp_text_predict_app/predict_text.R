# Load library
library(tidyr)
library(tm)
library(dplyr)

# read in the RData
unigram_df <- readRDS("unigram.RData")
bigram_df <- readRDS("bigram.RData")
trigram_df <- readRDS("trigram.RData")
quadgram_df <- readRDS("quadgram.RData")

# "stupid" back-off predict function
predictText <- function(inputtext){
        # clean user input
        inputtext <- inputtext %>% 
                tolower() %>%
                iconv() %>%
                removeWords(stopwords(kind = "en"))
        inputtext <- gsub("[0-9]", "", inputtext)
        inputtext <- gsub("[[:punct:]]", "", inputtext)        
        inputtext <- gsub("\\s+", " ", inputtext)
        input <- strsplit(inputtext, split = " ")[[1]]
        
        # the below algorithm
        # step1: check last 3 words of user input text against quadgram for match
        # step2: if none found, then check last 2 words against trigram
        # step3: then check the last word against bigram
        # step4: calculate max-likelihood estimate (MLE) score for all predict word
        
        input3 <- paste0(tail(input, 3), collapse = " ")
        quad <- subset(quadgram_df, begin == input3)
        quad$freq <- round(quad$freq / sum(quad$freq), 3)
        quad <- head(select(quad, end, freq_quad = freq), 10)
        
        input2 <- paste0(tail(input, 2), collapse = " ")
        tri <- subset(trigram_df, begin == input2)
        tri$freq <- round(0.4 * tri$freq / sum(tri$freq), 3)
        tri <- head(select(tri, end, freq_tri = freq), 10)
        
        input1 <- paste0(tail(input, 1), collapse = " ")
        bi <- subset(bigram_df, begin == input1)
        bi$freq <- round(0.4 * bi$freq / sum(bi$freq), 3)
        bi <- head(select(bi, end, freq_bi = freq), 10)
        
        # merge above results
        total <- merge(quad, tri, by = "end", all = TRUE)
        total <- merge(total, bi, by = "end", all = TRUE)
        total[is.na(total)] <- 0
        total["freq_sum"] <- rowSums(total[, 2:4])
        total <- arrange(total, desc(freq_quad), desc(freq_tri), desc(freq_bi))
        predict <- head(total, 3)$end
        return(predict)
}

