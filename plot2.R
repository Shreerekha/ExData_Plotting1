# plot2.R 
# This program plots Global Active power against the days of the week
# Input file: household_power_consumption.txt in working directory.
# Output file : plot2.png

library(sqldf)
library(dplyr)

#Downloading data from website

    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile ="./temp.zip")


#Getting Data 
## sqldf used to select only required rows.

    fi <- file(unzip("./temp.zip","household_power_consumption.txt"))
    powerdata <- read.csv.sql(sql = "SELECT * from fi WHERE Date in ('1/2/2007','2/2/2007')", sep = ";", header = TRUE)
    close(fi) 
    
   
#  Preparing Data
## Adding a new column combining date and time
## mutate function from dplyr is used to add an extra column 
## Converts the DateTime variable from char to positxct. 
    
    powerdata <- mutate(powerdata, DateTime = paste(powerdata$Date, powerdata$Time))
  
    powerdata$DateTime <-strptime(powerdata$DateTime, format = "%d/%m/%Y %H:%M:%S")

## Setting graphic device and parameters

    par(bg = "transparent")
    png(filename = "plot2.png", width = 480, height = 480)

##Plotting Graph

    plot(powerdata$DateTime, powerdata$Global_active_power, xlab = " ", ylab = "Global Active Power (Kilowatt)", col = "black", type = "l")

## Closing graphic device

    dev.off()