# Plotting Assignment 1 for Exploratory Data Analysis
# 

# libraries
library(readr)
library(ggplot2)
library(dplyr)
library(lubridate)

#Reading the data, replace "?" with NA
df<-read.csv(unz("household_power_consumption.zip","household_power_consumption.txt"), sep=";", na=c("","NA","?"))
raw_data <- tbl_df(df)
rm("df")
str(raw_data)
summary(raw_data)

#Data cleaning
#  1- convert date strings to Date objects
#  2- filter dates to keep only 2007-02-01 and 2007-02-02
clean_data <- mutate( raw_data, Date  = as.Date(strptime(Date, format="%d/%m/%Y")) ) %>%
  filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02") ) 
str(clean_data)

hist(clean_data$Global_active_power)
summary(clean_data)

if( dim(clean_data)[1] != 2*24*60 ){
  stop("wrong number of entries : ", dim(clean_data)[1] )
}

hist(clean_data$Global_active_power, 
    col="red", 
    xlab="Global Active Power (kilowatts)",
    ylab="Frequency",
    main="Global Active Power" )

## Copy plot to a PNG file
dev.copy(png, file = "plot1.png")
dev.off()
