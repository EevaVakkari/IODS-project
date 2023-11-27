##Eeva Vakkari
#27.11.2023
#Assignment 4 data wrangling
#Using two UNDP Human development report data sets "Human development" and "Gender inequality" to study the phenomena in different countries
#For reference, see <https://hdr.undp.org/data-center/human-development-index#/indicies/HDI>

#Loading libraries, I'll take tidyr and dplyr in addition to the instructed readr, just in case I would need them, as I usually do. 
library(tidyr)
library(readr)
library(dplyr)

#Reading the data sets into R, as instructed
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#Exploring the data sets and writing summaries
str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)

#Viewing the variables (column names)
View(hd)
View(gii)

#Renaming the variables with shortened names as in Kimmo's instructions
hd <- hd %>%
  rename(
    HDI_rank = `HDI Rank`,
    HDI = `Human Development Index (HDI)`,
    GNI = `Gross National Income (GNI) per Capita`,
    Life_Exp = `Life Expectancy at Birth`,
    Edu_Exp = `Expected Years of Education`, 
    Mean_Edu_Exp = `Mean Years of Education`,
    GNI_HDI = `GNI per Capita Rank Minus HDI Rank`
  ) #I'll keep Country as such 

gii <- gii %>%
  rename(
    GII_rank = `GII Rank`,
    GII = `Gender Inequality Index (GII)`,
    Mat_Mort = `Maternal Mortality Ratio`,
    Ado_Birth = `Adolescent Birth Rate`,
    Parli_F = `Percent Representation in Parliament`,
    Edu2_F = `Population with Secondary Education (Female)`,
    Edu2_M = `Population with Secondary Education (Male)`,
    Labo_F = `Labour Force Participation Rate (Female)`,
    Labo_M = `Labour Force Participation Rate (Male)`
  )

#Checking that renaming has worked
View(hd)
View(gii)

#Creating two new variables into Gender inequality data (gii)
gii <- mutate(gii, Edu2_FM = Edu2_F / Edu2_M)
gii <- mutate(gii, Labo_FM = Labo_F / Labo_M)
#Verifying that mutations were successful
head(gii)
dim(gii)
#Looks good

#Joining the data sets: identifier "Country" and keeping only the countries which are shared between both data sets
human <- inner_join(hd, gii, by = "Country")

#Checking it out
str(human)
#There seems to be 19 variables and 195 observations, as instructed.

#Making a csv
write.csv(human, "human.csv")