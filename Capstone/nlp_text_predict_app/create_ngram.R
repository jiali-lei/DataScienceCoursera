# This R script is continued from nlp_text_predict_EDA.Rmd.
# the necesary variables are:
# unigram_df, bigram_df, trigram_df, quadgram_df

# load library
library(dplyr)
library(tm)

# setwd("./Documents/Coursera/Data Science Specialization/Capstone/nlp_text_predict_app/")

# 1-gram
unigram_df <- unigram_df %>% filter(freq >= 1)
saveRDS(unigram_df, "unigram.RData")

# bi-gram
split_bigram <- strsplit(bigram_df$n_grams, split = " ")
bigram_df <- bigram_df %>%
        mutate(begin = sapply(split_bigram, "[[", 1), 
               end = sapply(split_bigram, "[[", 2)) %>%
        select(begin, end, freq) %>%
        filter(freq >= 1)
saveRDS(bigram_df, "bigram.RData")

# tri-gram
split_trigram <- strsplit(trigram_df$n_grams, split = " ")
trigram_df <- trigram_df %>%
        mutate(begin = paste(sapply(split_trigram, "[[", 1), 
                             sapply(split_trigram, "[[", 2),
                             sep = " "),
               end = sapply(split_trigram, "[[", 3)) %>%
        select(begin, end, freq) %>%
        filter(freq >= 1)
saveRDS(trigram_df, "trigram.RData")

# quad-gram
split_quadgram <- strsplit(quadgram_df$n_grams, split = " ")
quadgram_df <- quadgram_df %>%
        mutate(begin = paste(sapply(split_quadgram, "[[", 1), 
                             sapply(split_quadgram, "[[", 2),
                             sapply(split_quadgram, "[[", 3),
                             sep = " "),
               end = sapply(split_quadgram, "[[", 4)) %>%
        select(begin, end, freq) %>%
        filter(freq >= 1)
saveRDS(quadgram_df, "quadgram.RData")


# to free memory
rm(split_bigram)
rm(split_trigram)
rm(split_quadgram)
