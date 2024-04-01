
#install.packages("tidyverse")
library(tidyverse)
library (ggplot2)
library(dplyr)

#set file path
file_path_one <- file.path("Data", "bf44eb44-a7cc-404d-bdd1-2eb183c4487fAviationData.csv")
file_path_one

#Import the Data
boeing_db<- read.csv(file = file_path_one)
View(boeing_db)

#Inspect data
head(boeing_db) # View the first few rows
str(boeing_db)  # Check the structure
summary(boeing_db) # Summary statistics

# Calculate top crashes with the highest fatalities
top_crashes <- boeing_db %>%
  group_by(Model, ) %>%
  summarise(Total_Fatalities = sum(FatalInjuryCount, na.rm = TRUE)) %>%
  arrange(desc(Total_Fatalities)) 
View(top_crashes)

# Print top crashes
print(top_crashes)

#-------#
theboeing_db <-



#-------------#

# Convert EventDate to a proper datetime object
boeing_db$EventDate <- as.POSIXct(boeing_db$EventDate, format = "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")

# Extract year from EventDate
boeing_db$Year <- lubridate::year(boeing_db$EventDate)

# Summarize by year and make
summary_by_year_model <- boeing_db %>%
  group_by(Year, Model) %>%
  summarise(Num_Incidents = n(), Total_Fatalities = sum(FatalInjuryCount, na.rm = TRUE))

# Print summary by year and make
View(summary_by_year_model)

#----------------------------------#
# Summarize by year, model, country, and operator
summary_by_year_model_country_operator <- boeing_db %>%
  group_by(Year, Model, Country, Operator,EventType) %>%
  summarise(Num_Incidents = n(), 
            Total_Fatalities = sum(FatalInjuryCount, na.rm = TRUE),
            Total_Serious_Injuries = sum(SeriousInjuryCount, na.rm = TRUE))

# Print the updated summary dataframe
View(summary_by_year_model_country_operator)

# Export the data to CSV
write.csv(summary_by_year_model_country_operator, file = "summary_by_year_model_country_operator.csv", row.names = FALSE)
#--------------#


# Filter data for the last decade starting from 2010
boeing_db_last_decade <- boeing_db %>%
  filter(Year >= 2010)

# Summarize by year, model, country, operator, and event type
summary_by_year_model_country_operator <- boeing_db_last_decade %>%
  group_by(Year, Model, Country, Operator, EventType) %>%
  summarise(Num_Incidents = n(), 
            Total_Fatalities = sum(FatalInjuryCount, na.rm = TRUE),
            Total_Serious_Injuries = sum(SeriousInjuryCount, na.rm = TRUE))

# Print the updated summary dataframe
View(summary_by_year_model_country_operator)

# Export the data to CSV
write.csv(summary_by_year_model_country_operator, file = "boeing_incidents.csv", row.names = FALSE)

#
library(xlsx)
# Export the data to Excel
write_xlsx(summary_by_year_model_country_operator, "summary_by_year_model_country_operator.xlsx")