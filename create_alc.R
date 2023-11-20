#Eeva Vakkari
#20.11.2023
#Assignment 3 data wrangling
#Using a data set from UCI machine learning repository <http://www.archive.ics.uci.edu/dataset/320/student+performance>
#Student performance data about mathematics and Portuguese with alcohol consumption information
library(tidyverse)
install.packages("boot")
install.packages("readr")
math <- read.csv("student-mat.csv",sep=";",header=TRUE)
por <- read.csv("student-por.csv",sep=";",header=TRUE)
str(math)
dim(math)
str(por)
dim(por)
#The data consists of 395 and 694 observations of the same 33 variables for mathematics and Portuguese, respectively. The variables are both numerical and characters.
library(dplyr)
free_cols <-  c("failures", "paid", "absences", "G1", "G2", "G3")
join_cols <- setdiff(colnames(por), free_cols)
math_por <- inner_join(math, por, by=join_cols, suffix = c(".math", ".por"))
str(math_por)
dim(math_por)
#The joined data is composed of 370 observations and 39 variables.
alc <- select(math_por, all_of(join_cols))
# print out the columns not used for joining (those that varied in the two data sets)
free_cols
# Copied from the exercise 3.3: for every column name not used for joining
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)
glimpse(alc)
#The joined data seems to be as instructed and it has the two added columns for alcohol usage. Writing csv:
write.csv(alc, "alc.csv")
