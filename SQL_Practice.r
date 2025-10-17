## SQL Practice

# Load Packages
library(DBI)
library(RSQLite)
library(sqldf)
# Connect to a SQLite database (will create if it doesn’t exist)
con <- dbConnect(RSQLite::SQLite(), "mydata.db")
# Load data
education <- read.csv("education.csv")
head(education)
colnames(education)

## OVERVIEW 
result0 <- sqldf("SELECT COUNT(*) AS num_rows FROM education")
View(result0)

## GENERAL SQL EXAMPLES ########################################################
# Example: select all female students
result1 <- sqldf("SELECT * FROM education WHERE Gender = 'female'") 
View(result1)

# Example: students with MathScore > 90
result2 <- sqldf("SELECT student_ID, MathScore, ReadingScore FROM education WHERE MathScore > 90")
View(result2)

# Example: count of students by Gender
result3 <- sqldf("SELECT Gender, COUNT(*) as count FROM education GROUP BY Gender")
View(result3)

# Top 10 students by MathScore
top_math <- sqldf("SELECT student_ID, MathScore FROM education ORDER BY MathScore DESC LIMIT 10")
View(top_math)

## COUNT CATEGORICAL VARIABLES ##################################################
# Count of students by Gender
count_gender <- sqldf("SELECT Gender, COUNT(*) AS count FROM education GROUP BY Gender")
View(count_gender)

# Count by EthnicGroup
count_ethnic <- sqldf("SELECT EthnicGroup, COUNT(*) AS count FROM education GROUP BY EthnicGroup")
View(count_ethnic)

# Count by ParentEduc
count_parent_educ <- sqldf("SELECT ParentEduc, COUNT(*) AS count FROM education GROUP BY ParentEduc")
View(count_parent_educ)

# Count by multiple categorical variables (e.g., Gender and TestPrep)
count_gender_testprep <- sqldf("
  SELECT Gender, TestPrep, COUNT(*) AS count
  FROM education
  GROUP BY Gender, TestPrep
  ORDER BY Gender, TestPrep
")
View(count_gender_testprep)

## DISTRIBUTION OF CONTINUOUS VARIABLES ########################################
math_stats <- sqldf("
  SELECT 
    MIN(MathScore) AS min_score,
    MAX(MathScore) AS max_score,
    AVG(MathScore) AS avg_score
  FROM education
")
View(math_stats)

# Summary stats for ReadingScore and WritingScore
reading_writing_stats <- sqldf("
  SELECT 
    AVG(ReadingScore) AS avg_reading,
    AVG(WritingScore) AS avg_writing,
    MIN(ReadingScore) AS min_reading,
    MAX(ReadingScore) AS max_reading
  FROM education
")
View(reading_writing_stats)

# Average MathScore by Gender
avg_math_gender <- sqldf("
  SELECT Gender, AVG(MathScore) AS avg_math
  FROM education
  GROUP BY Gender
")
View(avg_math_gender)

# Average ReadingScore and WritingScore by LunchType
avg_scores_lunch <- sqldf("
  SELECT LunchType, AVG(ReadingScore) AS avg_reading, AVG(WritingScore) AS avg_writing
  FROM education
  GROUP BY LunchType
")
View(avg_scores_lunch)

# Average MathScore by Gender and TestPrep
avg_math_gender_testprep <- sqldf("
  SELECT Gender, TestPrep, AVG(MathScore) AS avg_math
  FROM education
  GROUP BY Gender, TestPrep
  ORDER BY Gender, TestPrep
")
View(avg_math_gender_testprep)

## FILTER AND COMBINE CONDITIONS ###############################################
# Female students with MathScore > 80
high_math_female <- sqldf("
  SELECT *
  FROM education
  WHERE Gender = 'female' AND MathScore > 80
")
View(high_math_female)

# Students with WritingScore > 85 and ReadingScore > 85
high_read_write <- sqldf("
  SELECT student_ID, WritingScore, ReadingScore
  FROM education
  WHERE WritingScore > 85 AND ReadingScore > 85
")
View(high_read_write)

facet_summary <- sqldf("
  SELECT Gender, PracticeSport,
         COUNT(*) AS count,
         AVG(MathScore) AS avg_math,
         AVG(ReadingScore) AS avg_reading,
         AVG(WritingScore) AS avg_writing
  FROM education
  GROUP BY Gender, PracticeSport
  ORDER BY Gender, PracticeSport
")
View(facet_summary)
