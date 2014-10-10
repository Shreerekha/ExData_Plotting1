# plot3.R 
# This program plots multiple Sub Metering readings against the days of the week
# in single graph.
# Input file: household_power_consumption.txt in working directory.
# Output file : plot3.png


library(sqldf)
library(dplyr)

#Downloading data from website

    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile ="./temp.zip")


#Getting Data 
## sqldf used to select only required rows

    fi <- file(unzip("./temp.zip","household_power_consumption.txt"))
    powerdata <- read.csv.sql(sql = "SELECT * from fi WHERE Date in ('1/2/2007','2/2/2007')", sep = ";", header = TRUE)
    close(fi) 

# Preparing Data
## Adding a new column combining date and time using mutate function from dplyr.
## Converting the DateTime variable from char to positxct. 

    powerdata <- mutate(powerdata, DateTime = paste(powerdata$Date, powerdata$Time))
    
    powerdata$DateTime <-strptime(powerdata$DateTime, format = "%d/%m/%Y %H:%M:%S")


## Setting graphic device for plot
    
    par(bg = "transparent")
    png(filename = "plot3.png", width = 480, height = 480)

##Plotting the graph

    plot(powerdata$DateTime, powerdata$Sub_metering_1, xlab = " ", ylab = " Energy sub metering", col = "black", type = "l")
    lines(powerdata$DateTime, powerdata$Sub_metering_2, col = "red")
    lines(powerdata$DateTime, powerdata$Sub_metering_3, col = "blue")
    legend("topright", lwd=1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Closing graphic device
    
     dev.off()