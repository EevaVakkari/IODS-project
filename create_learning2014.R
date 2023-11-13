#Eeva Vakkari
#13.11.2023
#Assignment 2 data wrangling
library(tidyverse) 
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
lrn14$attitude <- lrn14$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])
str(lrn14)
dim(lrn14)
#The data consists of 63 numerical and 1 character variables. All together 183 observations.
library(dplyr)
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
analysis <- select(lrn14, one_of(keep_columns))
analysis <- filter_if(analysis, is.numeric, all_vars((.) != 0)) #removing all zeros
setwd("~/Polyembryony_R/IODS/IODS-project/data")
write.csv(analysis, "learning2014.csv", row.names = F)
a <- read.csv("learning2014.csv")
str(a)
head(a)
#Looking good. Continuing into analysis part of the assignment.
