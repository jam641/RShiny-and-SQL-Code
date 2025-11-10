## SQL GROUP BY Practice (SQLite in R)

## This script demonstrates doing SQL subqueries and using the JOIN functions in SQLite.

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

education1 <- read.csv("education_split1.csv")
head(education1)
colnames(education1)

education2 <- read.csv("education_split2.csv")
head(education2)
colnames(education2)

## OVERVIEW 
result0 <- sqldf("SELECT COUNT(*) AS num_rows
                 FROM education")
head(result0)
# SELECT COUNT(*) AS num_rows
  # FROM EDUCATION

## SUBQUERIES PRACTICE #########################################################
SUBQUERY1 <- sqldf("SELECT student_ID, School, MathScore
                   FROM education
                   WHERE MathScore = (
                    SELECT max(MathScore)
                    FROM education)")
head(SUBQUERY1)
# SELECT student_ID, School, MathScore
  # FROM education
  # WHERE MathScore = (
    # SELECT max(MathScore)
    # FROM education;

SUBQUERY2 <- sqldf("SELECT School, ReadingScore
                    FROM education
                    WHERE School IN (
                      SELECT School FROM education
                      WHERE School > 25)
                    ORDER BY School")
head(SUBQUERY2)
# SELECT School, ReadingScore
  # FROM education
  # WHERE School IN (
    # SELECT School FROM education
    # WHERE School > 25)
    # ORDER BY School;

QUERY1 <- sqldf("SELECT School, SUM(MathScore + ReadingScore + WritingScore) AS TotalScore
                FROM education
                GROUP BY School") 
head(QUERY1)
# SELECT School, SUM(MathScore + ReadingScore + WritingScore) AS TotalScore
  # FROM education
  # GROUP BY School;

SUBQUERY4 <- sqldf("SELECT student_ID, School, WritingScore
                   FROM education
                   WHERE WritingScore = (
                    SELECT MIN(WritingScore)
                    FROM education)")
head(SUBQUERY4)
# SELECT StudentID, School, WritingScore
  # FROM education
  # WHERE WritingScore = (
    # SELECT MIN(WritingScore)
    # FROM education);

## JOINS #######################################################################
JOIN1 <- sqldf("SELECT student_ID, ParentMaritalStatus, ParentEduc
              FROM education1
              JOIN education2
              USING(student_ID)")
head(JOIN1)
# SELECT student_ID, ParentMaritalStatus, ParentEduc 
  # FROM education1
  # JOIN education2
  # USING(student_ID);

JOIN2 <- sqldf("SELECT School, ParentMaritalStatus, ParentEduc
              FROM education1
              JOIN education2
              USING(School)")
head(JOIN2)
# SELECT School, ParentMaritalStatus, ParentEduc 
  # FROM education1
  # JOIN education2 USING(School);

JOIN3 <- sqldf("SELECT School, education1.student_ID, ParentMaritalStatus, ParentEduc
              FROM education1
              JOIN education2
              USING(School)")
head(JOIN3)
# SELECT School, education1.studentID, ParentMaritalStatus, ParentEduc 
  # FROM education1
  # JOIN education2
  # USING(School);

JOIN4 <- sqldf("SELECT School, ParentMaritalStatus, ParentEduc
              FROM education1 E1
              JOIN education2 E2
              USING(School)")
head(JOIN4)
# SELECT School, education1.studentID, ParentMaritalStatus, ParentEduc 
  # FROM education1 E1
  # JOIN education2 E2
  # USING(School);

JOIN5 <- sqldf("SELECT E2.ParentEduc, E1.student_ID
                FROM education1 AS E1
                JOIN education2 AS E2
                ON E1.student_ID = E2.student_ID
                WHERE E1.LunchType = 'standard'")
head(JOIN5)
# SELECT E2.ParentEduc, E1.student_ID
  # FROM education1 AS E1
  # JOIN education2 AS E2
  # ON E1.student_ID = E2.student_ID
  # WHERE E1.LunchType = 'standard'

JOIN6 <- sqldf("SELECT E1.student_ID, SUM(E1.ReadingScore + E2.WritingScore) AS EnglishScore
               FROM education1 AS E1
               JOIN education2 AS E2
               ON E1.student_ID = E2.student_ID
               GROUP BY E1.student_ID
               HAVING SUM(E1.ReadingScore + E2.WritingScore) < 75")
head(JOIN6)
# SELECT E1.student_ID, SUM(E1.ReadingScore + E2.WritingScore) AS EnglishScore
  # FROM education1 AS E1
  # JOIN education2 AS E2
  # GROUP BY E1.student_ID
  # HAVING SUM(E1.ReadingScore + E2.WritingScore) < 75;

JOIN7 <- sqldf("SELECT E2.IsFirstChild, E1.ParentMaritalStatus
                FROM education1 as E1
                LEFT JOIN education2 AS E2
                ON E1.student_ID = E2.student_ID
                GROUP BY E2.IsFirstChild, E1.ParentMaritalStatus
               ORDER BY 2 DESC")
head(JOIN7)
# SELECT E2.IsFirstChild, E1.ParentMaritalStatus
  # FROM education1 as E1
  # LEFT JOIN education2 AS E2
  # ON E1.student_ID = E2.student_ID
  # GROUP BY E2.IsFirstChild, E1.ParentMaritalStatus
  # ORDER BY 2 DESC

JOIN8 <- sqldf("SELECT E1.student_ID, MathScore, ReadingScore, WritingScore
               FROM education1 E1 LEFT JOIN
               education2 E2 ON
               E1.student_ID = E2.student_ID
               GROUP BY E1.student_ID
               HAVING COUNT(MathScore) = 75")
head(JOIN8)
# SELECT E1.student_ID, MathScore, ReadingScore, WritingScore
  # FROM education1 E1 LEFT JOIN
  # education2 E2 ON
  # E1.student_ID = E2.student_ID
  # GROUP BY E1.student_ID
  # HAVING COUNT(MathScore) = 75
