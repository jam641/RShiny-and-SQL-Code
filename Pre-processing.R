## Load Packages
library(tidyverse)

# Load Data
education1 <- readr::read_csv('edu_final.csv')
head(education1)

# Change Data Types
education1 %>% mutate(X = as.factor(X),
                      Gender = as.factor(Gender),
                      EthnicGroup = as.factor(EthnicGroup),
                      ParentEduc = as.factor(ParentEduc),
                      LunchType = as.factor(LunchType),
                      TestPrep = as.factor(TestPrep),
                      ParentMaritalStatus = as.factor(ParentMaritalStatus),
                      PracticeSport = as.factor(PracticeSport),
                      IsFirstChild = as.factor(IsFirstChild),
                      NrSiblings = as.factor(NrSiblings),
                      TransportMeans = as.factor(TransportMeans),
                      WklyStudyHours = as.factor(WklyStudyHours),
                      MathScore = as.numeric(MathScore),
                      ReadingScore = as.numeric(ReadingScore),
                      WritingScore = as.numeric(WritingScore),
                      start_x = as.numeric(start_x),
                      school = as.factor(school)) -> education2

education2 <- education2 %>%
  mutate(WklyStudyHours.rc = recode(WklyStudyHours, "10-May" = "5 to 10"))

education2 %>% select(X, Gender, EthnicGroup, ParentEduc, LunchType, TestPrep,
                      ParentMaritalStatus, PracticeSport, IsFirstChild, NrSiblings,
                      TransportMeans, WklyStudyHours.rc, MathScore, ReadingScore, 
                      WritingScore, school) -> education

education %>% glimpse()

education <- education %>% 
  rename("student_ID" = "X")
education <- education %>% 
  rename("School" = "school")
education <- education %>% 
  rename("WklyStudyHours" = "WklyStudyHours.rc")
education %>% mutate(student_ID = as.factor(student_ID))

education %>% glimpse()

write_csv(education, file='education.csv')
