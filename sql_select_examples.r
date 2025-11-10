## SQL SELECT Practice (SQLite in R)

## This script demonstrates basic SQL SELECT statements in SQLite.

## Additional comments are added into code to demonstrate PostgreSQL

## SET UP SCRIPT ###############################################################
## LOAD PACKAGES
library(DBI)
library(RSQLite)
library(sqldf)

## CONNECT TO/CREATE SQLite DATABASE
con <- dbConnect(RSQLite::SQLite(), "mydata.db")

## LOAD DATA
education <- read.csv("education.csv")
head(education)
colnames(education)

## OVERVIEW 
result0 <- sqldf("SELECT COUNT(*) AS num_rows
                 FROM education")
head(result0)
# SELECT COUNT(*) AS num_rows
  # FROM EDUCATION

## SELECT PRACTICE #############################################################
SELECT1 <- sqldf("SELECT LunchType, NrSiblings, ParentEduc 
                 FROM education") 
head(SELECT1)
# SELECT LunchType, NrSiblings, ParentEduc
  # FROM education;

SELECT2 <- sqldf("SELECT Gender, ReadingScore * WritingScore AS EnglishScore
                 FROM education")
head(SELECT2)
# SELECT Gender, ReadingScore * WritingScore AS EnglishScore
  # FROM education; 

SELECT3 <- sqldf("SELECT CONCAT(NrSiblings, ' ', NrSiblings) AS SiblingInformation
                 FROM education")
head(SELECT3)
# SELECT CONCAT(NrSiblings, ' ' NrSiblings) AS SiblingInformation
  # FROM education;

SELECT4 <- sqldf("SELECT MathScore, ReadingScore, WritingScore
                 FROM education")
head(SELECT4)
# SELECT MathScore, ReadingScore, WritingScore
  # FROM education;

SELECT5 <- sqldf("SELECT CONCAT(ParentEduc, ' ', ParentMaritalStatus) AS ParentInformation, Gender
                 FROM education")
head(SELECT5)
# SELECT CONCAT(ParentEduc, ' ', ParentMaritalStatus) AS ParentInformation, Gender
  # FROM education;

SELECT6 <- sqldf("SELECT ReadingScore + WritingScore + MathScore AS TotalScore
                 FROM education")
head(SELECT6)
# SELECT ReadingScore + WritingScore + MathScore AS TotalScore
  # FROM education;