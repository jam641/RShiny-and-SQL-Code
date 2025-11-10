## SQL GROUP Practice (SQLite in R)

## This script demonstrates using SQL aggregate functions in SQLite.

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

## GROUP FUNCTIONS PRACTICE ####################################################
GROUP1 <- sqldf("SELECT COUNT(*) AS School
                FROM education")
head(GROUP1)
# SELECT COUNT(*) AS School
  # FROM education;

GROUP2 <- sqldf("SELECT COUNT(DISTINCT Gender) AS Gender
                FROM education")
head(GROUP2)
# SELECT COUNT(DISTINCT Gender) AS Gender
  # FROM education;

GROUP3 <- sqldf("SELECT SUM(MathScore) AS Arithmatic
                FROM education")
head(GROUP3)
# SELECT SUM(MathScore) AS Arithmatc
  # FROM education;

GROUP4 <- sqldf("SELECT MAX(ReadingScore) AS HighReadingScore
                FROM education")
head(GROUP4)
# SELECT MAX(ReadingScore) AS HighReadingScore
  # FROM education;

GROUP5 <- sqldf("SELECT MIN(WritingScore) AS LowWritingScore
                FROM education")
head(GROUP5)
# SELECT MIN(WritingScore) AS LowWritingScore
  # FROM education;

GROUP6 <- sqldf("SELECT AVG(MathScore) AS MeanMathScore
                FROM education")
head(GROUP6)
# SELECT AVG(MathScore) AS MeanMathScore
  # FROM education;

GROUP7 <- sqldf("SELECT ROUND(AVG(MathScore), 2) AS MeanMathScore
                FROM education")
head(GROUP7)
# SELECT ROUND(AVG(MathScore), 2) AS MeanMathScore
  # FROM education;

GROUP8 <- sqldf("SELECT student_ID, School, Gender
                FROM education
                WHERE student_ID IN (1, 2, 3) AND School IN (5)")
head(GROUP8)
# SELECT student_ID, School, Gender
  # FROM education
  # WHERE student_ID IN (1, 2, 3) AND School IN (5);
