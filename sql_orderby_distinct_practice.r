## SQL ORDER BY and DISTINCT Practice (SQLite in R)

## This script demonstrates sorting and distinct value selection using SQL  
  # ORDER BY and DISTINCT in SQLite.

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

## ORDER BY AND DISTINCT PRACTICE ##############################################
DISTINCT1 <- sqldf("SELECT COUNT(*)
                   FROM education")
head(DISTINCT1)
# SELECT COUNT(*)
  # FROM education;

DISTINCT2 <- sqldf("SELECT COUNT(DISTINCT student_ID)
                   FROM education")
head(DISTINCT2)
# SELECT COUNT(DISTINCT student_ID)
  # FROM education;

DISTINCT3 <- sqldf("SELECT COUNT(DISTINCT School)
                   FROM education")
head(DISTINCT3)
# SELECT COUNT(DISTINCT School)
  # FROM education;

ORDERBY1 <- sqldf("SELECT student_ID, School, MathScore
                  FROM education
                  ORDER BY student_ID")
head(ORDERBY1)
# SELECT student_ID, School, MathScore
  # FROM education
  # ORDER BY student_ID;

ORDERBY2 <- sqldf("SELECT student_ID, School, MathScore, ReadingScore, WritingScore
                  FROM education
                  ORDER BY MathScore")
head(ORDERBY2)
# SELECT student_ID, School, MathScore, ReadingScore, WritingScore
  # FROM education
  # ORDER BY MathScore;

ORDERBY3 <- sqldf("SELECT student_ID, School, MathScore, ReadingScore, WritingScore
                  FROM education
                  ORDER BY MathScore ASC")
head(ORDERBY3)
# SELECT student_ID, School, MathScore, ReadingScore, WritingScore
  # FROM education
  # ORDER BY MathScore ASC;

ORDERBY4 <- sqldf("SELECT student_ID, School, MathScore, ReadingScore, WritingScore
                  FROM education
                  ORDER BY MathScore DESC")
head(ORDERBY4)
# SELECT student_ID, School, MathScore, ReadingScore, WritingScore
  # FROM education
  # ORDER BY MathScore DESC;

ORDERBY5 <- sqldf("SELECT student_ID, School, ReadingScore
                  FROM education
                  ORDER BY ReadingScore DESC LIMIT 10")
head(ORDERBY5)
# SELECT student_ID, School, ReadingScore
# FROM education
# ORDER BY ReadingScore DESC LIMIT 10;
