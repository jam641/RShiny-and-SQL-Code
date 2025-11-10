## General SQL Practice

## This script demonstrates common SQL tasks including SELECT, WHERE, GROUP BY,
  # ORDER BY, aggregate functions, and filtering conditions in SQLite.

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

## GENERAL SQL EXAMPLES ########################################################
# Example: select all female students
result1 <- sqldf("SELECT * FROM education
                 WHERE Gender = 'female'") 
head(result1)

# Example: students with MathScore > 90
result2 <- sqldf("SELECT student_ID, MathScore, ReadingScore
                 FROM education
                 WHERE MathScore > 90")
head(result2)

# Example: COUNT of students by Gender
result3 <- sqldf("SELECT Gender, COUNT(*) as COUNT
                 FROM education
                 GROUP BY Gender")
head(result3)

# Top 10 students by MathScore
top_math <- sqldf("SELECT student_ID, MathScore
                  FROM education
                  ORDER BY MathScore DESC LIMIT 10")
head(top_math)

## COUNT CATEGORICAL VARIABLES ##################################################
# Count of students by Gender
CountGender <- sqldf("SELECT Gender, COUNT(*) AS COUNT
                     FROM education
                     GROUP BY Gender")
head(CountGender)

# Count by EthnicGroup
CountEthnic <- sqldf("SELECT EthnicGroup, COUNT(*) AS COUNT
                     FROM education
                     GROUP BY EthnicGroup")
head(CountEthnic)

# Count by ParentEduc
CountParentEduc <- sqldf("SELECT ParentEduc, COUNT(*) AS COUNT
                         FROM education
                         GROUP BY ParentEduc")
head(CountParentEduc)

# Count by multiple categorical variables (e.g., Gender and TestPrep)
CountGenderTestPrep<- sqldf("SELECT Gender, TestPrep, COUNT(*) AS COUNT
                            FROM education
                            GROUP BY Gender, TestPrep
                            ORDER BY Gender, TestPrep")
head(CountGenderTestPrep)

## DISTRIBUTION OF CONTINUOUS VARIABLES ########################################
# Summary stats for MathScore
MathStats <- sqldf("SELECT 
                   MIN(MathScore) AS min_score,
                   MAX(MathScore) AS max_score,
                   AVG(MathScore) AS avg_score
                   FROM education")
head(MathStats)

# Summary stats for ReadingScore and WritingScore
EnglishStats <- sqldf("SELECT AVG(ReadingScore) AS avg_reading,
                               AVG(WritingScore) AS avg_writing,
                               MIN(ReadingScore) AS min_reading,
                               MAX(ReadingScore) AS max_reading
                               FROM education")
head(EnglishStats)

# Average MathScore by Gender
AvgMath_byGender <- sqldf("SELECT Gender, AVG(MathScore) AS avg_math
                         FROM education
                         GROUP BY Gender")
head(AvgMath_byGender)

# Average ReadingScore and WritingScore by LunchType
AvgEnglish_byLunchType <- sqldf("SELECT LunchType, AVG(ReadingScore) AS avg_reading,
                                AVG(WritingScore) AS avg_writing
                                FROM education
                                GROUP BY LunchType")
head(AvgEnglish_byLunchType)

# Average MathScore by Gender and TestPrep
AvgMath_byGender_byTestPrep <- sqldf("SELECT Gender, TestPrep, AVG(MathScore) AS avg_math
                                     FROM education
                                     GROUP BY Gender, TestPrep
                                     ORDER BY Gender, TestPrep")
head(AvgMath_byGender_byTestPrep)

## FILTER AND COMBINE CONDITIONS ###############################################
# Female students with MathScore > 80
HighMathFemale <- sqldf("SELECT *
                        FROM education
                        WHERE Gender = 'female' AND MathScore > 80")
head(HighMathFemale)

# Students with WritingScore > 85 and ReadingScore > 85
HighEnglish <- sqldf("SELECT student_ID, WritingScore, ReadingScore
                     FROM education
                     WHERE WritingScore > 85 AND ReadingScore > 85")
head(HighEnglish)

# Broad Summary
facet_summary1 <- sqldf("SELECT Gender, PracticeSport, COUNT(*) AS COUNT,
                        AVG(MathScore) AS avg_math, AVG(ReadingScore) AS avg_reading,
                        AVG(WritingScore) AS avg_writing
                        FROM education
                        GROUP BY Gender, PracticeSport
                        ORDER BY Gender, PracticeSport")
head(facet_summary1)

facet_summary2 <- sqldf("SELECT School, ROUND(AVG(MathScore), 2) AS AvgMath,
                   COUNT(student_ID) AS NumStudents
                   FROM education
                   WHERE LunchType = 'standard'
                   GROUP BY School
                   HAVING AvgMath > 80
                   ORDER BY AvgMath DESC LIMIT 5")
head(facet_summary2)