# plot4.R 
# This program plots multiple graphs in the same window
# Input file: household_power_consumption.txt in working directory.
# Output file : plot4.png


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

# Preparing Data
## Adding a new column combining date and time using mutate function from dplyr.
## Then converting the DateTime variable from char to positxct. 

    powerdata <- mutate(powerdata, DateTime = paste(powerdata$Date, powerdata$Time))
    powerdata$DateTime <-strptime(powerdata$DateTime, format = "%d/%m/%Y %H:%M:%S")
 
    
## Setting graphic parameters for plots
    
    png(filename = "plot4.png", width = 480, height = 480)

## setting margins and number of plots per page
    
    par(mfrow = c(2,2))
    par(mar = c(4,4,1,1))
    par(bg ="white")

## Plotting the graphs

    plot(powerdata$DateTime, powerdata$Global_active_power, xlab = " ", ylab = "Global Active Power", col = "black", type = "l")

    plot(powerdata$DateTime, powerdata$Voltage, xlab = "datetime ", ylab = "Voltage", col = "black", type = "l")

    plot(powerdata$DateTime, powerdata$Sub_metering_1, xlab = " ", ylab = " Energy sub metering", col = "black", type = "l")
    lines(powerdata$DateTime, powerdata$Sub_metering_2, col = "red")
    lines(powerdata$DateTime, powerdata$Sub_metering_3, col = "blue")
    legend("topright", lwd=1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

    plot(powerdata$DateTime, powerdata$Global_reactive_power, xlab = "datetime ", ylab = "Global_Reactive_Power", col = "black", type = "l")

## Closing graphic device
    
    dev.off()
    
    
    
    