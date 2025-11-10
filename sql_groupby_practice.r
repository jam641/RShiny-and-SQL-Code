## SQL GROUP BY Practice (SQLite in R)

## This script demonstrates using SQL GROUP BY function in SQLite.

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

## GROUP BY PRACTICE ############################################################
GROUPBY1 <- sqldf("SELECT student_ID, SUM(MathScore) AS AccumulatedMathScores,
                  SUM(ReadingScore) AS AccumulatedReadingScores
                  FROM education
                  WHERE student_ID IN (1, 2, 3)
                  GROUP BY student_ID")
head(GROUPBY1)
# SELECT student_ID, SUM(MathScore) AS AccumulatedMathScores, 
  # SUM(ReadingScore) AS AccumulatedReadingScores
  # FROM education
  # WHERE student_ID IN (1, 2, 3)
  # GROUP BY student_ID;

GROUPBY2 <- sqldf("SELECT LunchType, COUNT(student_ID) AS Total
                  FROM education
                  GROUP BY LunchType")
head(GROUPBY2)
# SELECT LunchType, COUNT(student_ID) AS Total
  # FROM education
  # GROUP BY LunchType;

GROUPBY3 <- sqldf("SELECT WklyStudyHours, COUNT(student_ID) AS Total
                  FROM education
                  GROUP BY WklyStudyHours")
head(GROUPBY3)
# SELECT WklyStudyHours, COUNT(student_ID) AS Total
  # FROM education
  # GROUP BY WklyStudyHours;

GROUPBY4 <- sqldf("SELECT School, avg(ReadingScore) AS MeanReadingScore
                  FROM education
                  GROUP BY School
                  ORDER BY 2 DESC")
head(GROUPBY4)
# SELECT School, avg(ReadingScore) AS MeanReadingScore
  # FROM education
  # GROUP BY School
  # ORDER BY 2 DESC;

GROUPBY5 <- sqldf("SELECT School, avg(ReadingScore) AS MeanReadingScore
                  FROM education
                  GROUP BY School
                  ORDER BY 2 DESC LIMIT 1")
head(GROUPBY5)
# SELECT School, avg(ReadingScore) AS MeanReadingScore
  # FROM education
  # GROUP BY School
  # ORDER BY 2 DESC LIMIT 1;

GROUPBY6 <- sqldf("SELECT School, COUNT(student_ID) AS Total
                  FROM education
                  GROUP BY School
                  HAVING COUNT(student_ID) > 100
                  ORDER BY 2 DESC")
head(GROUPBY6)
# SELECT School, COUNT(student_ID) AS Total 
  # FROM education
  # GROUP BY School
  # HAVING COUNT(student_ID) > 100
  # ORDER BY 2 DESC;

GROUPBY7 <- sqldf("SELECT student_ID, SUM(ReadingScore + WritingScore) AS EnglishScore
                  FROM education
                  GROUP BY student_ID
                  ORDER BY 2 DESC LIMIT 5")
head(GROUPBY7)
# SELECT student_ID, SUM(ReadingScore + WritingScore) AS EnglishScore
  # FROM education
  # GROUP BY student_ID
  # ORDER BY 2 DESC LIMIT 5;

GROUPBY8 <- sqldf("SELECT COUNT(LunchType)
                  FROM education
                  WHERE student_ID > 0")
head(GROUPBY8)
# SELECT COUNT(LunchType)
  # FROM education
  # WHERE student_ID > 0;

GROUPBY9 <- sqldf("SELECT student_ID, COUNT(School) AS students
                  FROM education
                  GROUP BY student_ID
                  HAVING COUNT(School) > 15
                  ORDER BY 2 DESC")
head(GROUPBY9)
# SELECT student_ID, COUNT(Schoo) AS students
  # FROM education
  # GROUP BY student_ID
  # HAVING COUNT(School) > 15
  # ORDER BY 2 DESC;
