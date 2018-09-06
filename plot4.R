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

#Data cleaning
#  1- convert date strings to Date objects
#  2- filter dates to keep only 2007-02-01 and 2007-02-02
#  3- Create a variable timePOSIX to store (Date,Time) tie stamps
clean_data <- mutate( raw_data, Date  = as.Date(strptime(Date, format="%d/%m/%Y")) ) %>%
  filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02") ) %>%
  mutate(timePOSIX = ymd_hms(paste(Date,Time)))

if( dim(clean_data)[1] != 2*24*60 ){
  stop("wrong number of entries : ", dim(clean_data)[1] )
}

#Create the 2 x 2 plotting area
par(mfrow=c(2,2))

#Create plots
plot(clean_data$timePOSIX, clean_data$Global_active_power, 
     type="l",
     xlab="", 
     ylab="Global Active Power")


plot(clean_data$timePOSIX, clean_data$Voltage, 
     type="l",
     xlab="datetime", 
     ylab="Voltage")


plot(clean_data$timePOSIX, clean_data$Sub_metering_1, 
     type="l",
     xlab="", 
     ylab="Energy sub metering")
lines( clean_data$timePOSIX, clean_data$Sub_metering_2, col="red")
lines( clean_data$timePOSIX, clean_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue")
       )

plot(clean_data$timePOSIX, clean_data$Global_reactive_power, 
     type="l",
     xlab="datetime", 
     ylab="Global_reactive_power")


## Copy plot to a PNG file
dev.copy(png, file = "plot4.png")
dev.off()
