# Plotting Assignment 1 for Exploratory Data Analysis
# 

# libraries
library(readr)
library(ggplot2)
library(dplyr)
library(lubridate)

#Reading the data, replCE "?" with NA
df<-read.csv("household_power_consumption.txt", sep=";", na=c("","NA","?"))
raw_data <- tbl_df(df)
rm("df")
str(raw_data)
summary(raw_data)

#Data cleaning
#  1- convert date strings to Date objects
#  2- filter dates to keep only 2007-02-01 and 2007-02-02
clean_data <- mutate( raw_data, Date  = as.Date(strptime(Date, format="%d/%m/%Y")) ) %>%
  filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02") ) %>%
  mutate(timePOSIX = ymd_hms(paste(Date,Time)))

str(clean_data)
summary(clean_data)

if( dim(clean_data)[1] != 2*24*60 ){
  stop("wrong number of entries : ", dim(clean_data)[1] )
}
plot(clean_data$timePOSIX, clean_data$Global_active_power, 
     type="l",
     xlab="", 
     ylab="Global Active Power")


## Copy plot to a PNG file
dev.copy(png, file = "plot2.png")
dev.off()
