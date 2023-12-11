##Eeva Vakkari
#11.12.2023
#Assignment 6 data wrangling
#Using two data sets, BPRS and RATS, from MABS repository <https://github.com/KimmoVehkalahti/MABS>

#Loading libraries, I'll take tidyr and dplyr in addition to the instructed readr, just in case I would need them, as I usually do. 
library(tidyr)
library(readr)
library(dplyr)
library(tidyverse)
library(lme4)

#Reading data in R
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = T, sep = " ")
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T)

#Let's have a glimpse into the data sets
head(BPRS)
head(RATS)
summary(BPRS)
summary(RATS)
str(BPRS)
str(RATS)

#Both data sets are in wide format, i.e. one row represents one study subject and the columns stand for repetitive measurements from the same subject
#BPRS consists of 40 subjects, divided by two treatments into two groups, and 11 variables of which 9 are observation points in a time series and one is subject ID and one treatment code.
#RATS has 16 subjects and 13 variables of which one is subject ID, one is group code, and 11 are measurements in a time series.
#Now, all the variables are integer numbers despite some of them being clearly categorical by character.

#Converting the categorical variables of BPRS, "treatment" and "subject", into factors
BPRS$treatment <- as.factor(BPRS$treatment)
BPRS$subject <- as.factor(BPRS$subject)

#Converting the categorical variables of RATS, "ID" and "Group", into factors
RATS$ID <- as.factor(RATS$ID)
RATS$Group <- as.factor(RATS$Group)

#Checking that the conversions worked out
str(BPRS) 
str(RATS) 
#OK!

#The long form is good for time series, but it potentially makes use of several analysis tools ricky or impossible.
#Time series as a study setup itself implies that the observations are not independent, which has to be taken into account when doing stastistics.

#Converting the data sets from wide form into long form and adding "week" and "Time" variables into BPRS and RATS, respectively.
BPRSL <- pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "week",values_to = "bprs")
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), names_to = "Time", values_to = "rats")

#Let's see how the converted data sets look
head(BPRSL)
head(RATSL)
summary(BPRSL)
summary(RATSL)
str(BPRSL)
str(RATSL)
#Now, each measurement is at its own row, meaning that each subject is represented by several rows.
#The variables "treatment" and "subject", and "ID" and "Group" define the individual subjects in long form BPRSL and RATSL, respectively.
#Change into long form makes many analysis steps easier, including inter-dependent repeated measurements, as well as visualization.

#Saving the data sets in long form
write.csv(BPRSL, "BPRSL.csv", row.names = F, col.names = F)
write.csv(RATSL, "RATSL.csv", row.names = F, col.names = F)

#Data wrangling completed, continuing into the analysis exercise of week 6.