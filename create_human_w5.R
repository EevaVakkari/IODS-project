##Eeva Vakkari
#29.11.2023
#Assignment 5 data wrangling
#Using two UNDP Human development report data sets "Human development" and "Gender inequality" to study the phenomena in different countries. 
#For reference, see <https://hdr.undp.org/data-center/human-development-index#/indicies/HDI>
#The data sets were joined in last week's data wrangling exercise (see my code <https://github.com/EevaVakkari/IODS-project/blob/master/create_human.R>)
#The joined data depicts human development and gender inequality, as well as their components, in different countries.

#Loading libraries, I'll take tidyr and dplyr in addition to the instructed readr, just in case I would need them, as I usually do. 
library(tidyr)
library(readr)
library(dplyr)

#Just in case that I have screwed up something with data wrangling last week, I use Kimmo's csv file.

#Reading data in R
human <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.csv")

#Exploring the data
str(human)
dim(human)
View(human)
#There seems to be 19 variables and 195 observations, as instructed. Only "Country" is a character variable, the others are numerical.
#The variables are: HDI.rank = `HDI Rank`,  Country = `Country name`, HDI = `Human Development Index (HDI)`,  Life.Exp = `Life Expectancy at Birth`, Edu.Exp = `Expected Years of Education`, Edu.Mean = `Mean Years of Education`, GNI = `Gross National Income (GNI) per Capita`, GNI.Minus.Rank = `GNI per Capita Rank Minus HDI Rank`, GII.rank = `GII Rank`, GII = `Gender Inequality Index (GII)`, Mat.Mort = `Maternal Mortality Ratio`, Ado.Birth = `Adolescent Birth Rate`, Parli.F = `Percetange of female representatives in parliament`, Edu2.F = `Population with Secondary Education (Female)`, Edu2.M = `Population with Secondary Education (Male)`, Labo.F = `Labour Force Participation Rate (Female)`, Labo.M = `Labour Force Participation Rate (Male)`, Edu2.FM = `Edu2.F/Edu2.M`, Labo.FM = `Labo.F/Labo.M`

#Limiting the data set only to instructed variables by keeping the following 9 columns and removing NAs
keep_columns <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
analysis <- select(human, one_of(keep_columns))
analysis <- na.omit(analysis)

#Removing areas and keeping only countries in the analysis
View(analysis)
#There are 7 areas as last observations in the data frame: Arab States, East Asia and the Pacific, Europe and Central Asia, Latin America and the Caribbean, South Asia, Sub-Saharan Africa, World
#Removing those areas
n_until <- nrow(analysis) - 7
analysis <- analysis[1:n_until, ]

#Checking it up
str(analysis)
#Now there's 9 variables and 155 observations, OK.
View(analysis)
#Countries are included, no areas.

#Saving the data frame as "human" and saving it
human <- analysis
write.table(human, "human.txt", row.names = F, sep = ",", col.names = F)

#Continuing into analysis part of the week 5 exercise
