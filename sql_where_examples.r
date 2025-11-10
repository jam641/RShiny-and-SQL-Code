## SQL WHERE Practice (SQLite in R)

## This script demonstrates filtering data using SQL WHERE clauses in SQLite.

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

## WHERE PRACTICE ##############################################################
WHERE1 <- sqldf("SELECT NrSiblings
                FROM education
                WHERE NrSiblings > 3")
head(WHERE1)
# SELECT NrSiblings
  # FROM education
  # WHERE NrSiblings > 3;

WHERE2 <- sqldf("SELECT MathScore
                FROM education
                WHERE MathScore > 80")
head(WHERE2)
# SELECT MathScore
  # FROM education
  # WHERE MathScore > 80;

WHERE3 <- sqldf("SELECT student_ID, Gender, MathScore, ReadingScore, WritingScore
                FROM education
                WHERE MathScore > 80")
head(WHERE3)
# SELECT student_ID, Gender, MathScore, ReadingScore, WritingScore 
  # FROM education
  # WHERE MathScore > 80;

WHERE4 <- sqldf("SELECT student_ID, Gender, ParentEduc
                FROM education
                WHERE Gender = 'female'")
head(WHERE4)
# SELECT student_ID, Gender, ParentEduc
  # FROM education
  # WHERE Gender = 'female';

WHERE5 <- sqldf("SELECT student_ID, Gender, ParentEduc
                FROM education
                WHERE ParentEduc LIKE 'b%'")
head(WHERE5)
# SELECT student_ID, Gender, ParentEduc 
  # FROM education 
  # WHERE ParentEduc LIKE 'b%';

WHERE6 <- sqldf("SELECT student_ID, LunchType
                FROM education
                WHERE LunchType LIKE '_t%'")
head(WHERE6)
# SELECT student_ID, LunchType
  # FROM education
  # WHERE LunchType LIKE '_t%';

WHERE7 <- sqldf("SELECT student_ID, MathScore
                FROM education
                WHERE MathScore IN (20, 40)")
head(WHERE7)
# SELECT student_ID, MathScore
  # FROM education
  # WHERE MathScore IN (20, 40);

WHERE8 <- sqldf("SELECT student_ID, PracticeSport
                FROM education 
                WHERE PracticeSport IN ('regularly', 'never')")
head(WHERE8)
# SELECT student_ID, PracticeSport
  # FROM education
  # WHERE PracticeSport IN ('regularly', 'never');

WHERE9 <- sqldf("SELECT student_ID, WritingScore
                FROM education
                WHERE MathScore BETWEEN 20 AND 30")
head(WHERE9)
# SELECT student_ID, WritingScore
  # FROM education
  # WHERE MathScore BETWEEN 20 AND 30;

WHERE10 <- sqldf("SELECT student_ID, MathScore, ReadingScore, WritingScore
                 FROM education
                 WHERE MathScore > 50 AND ReadingScore > 50 AND WritingScore > 50")
head(WHERE10)
# SELECT student_ID, MathScore, ReadingScore, WritingScore
  # FROM education
  # WHERE MathScore > 50 AND ReadingScore > 50 AND WritingScore > 50;

WHERE11 <- sqldf("SELECT student_ID, MathScore, ReadingScore, WritingScore
                 FROM education
                 WHERE MathScore > 50 AND ReadingScore > 50 OR WritingScore > 50")
head(WHERE11)
# SELECT student_ID, MathScore, ReadingScore, WritingScore
  # FROM education
  # WHERE MathScore > 50 AND ReadingScore > 50 OR WritingScore > 50;

WHERE12 <- sqldf("SELECT student_ID, PracticeSport, WklyStudyHours
                 FROM education
                 WHERE PracticeSport <> 'never'")
head(WHERE12)
# SELECT student_ID, PracticeSport, WklyStudyHours
  # FROM education
  # WHERE PracticeSport <> 'never';

WHERE13 <- sqldf("SELECT student_ID, ReadingScore, WritingScore, MathScore,
                 (ReadingScore + WritingScore + MathScore) AS TotalScore
                 FROM education
                 WHERE (ReadingScore + WritingScore + MathScore) > 250")
head(WHERE13)
# SELECT student_ID, ReadingScore, WritingScore, MathScore,
  # (ReadingScore + WritingScore + MathScore) AS "Total Score" 
  # FROM education
  # WHERE (ReadingScore + WritingScore + MathScore) > 250;
