# plot1.R 
# This program plots Global Active power as a histogram.
# Input file: household_power_consumption.txt in working directory.
# Output file : plot1.png

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


## Setting graphic device and paramters

    par(bg= "transparent")
    png(filename = "plot1.png", width = 480, height = 480)

##Plotting Histogram

    hist(powerdata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatt)", ylab = "Frequency", col = "red")

## Closing graphic device

    dev.off()