################################################################################
## Specialization:   Data Science
## Course:           IV. Exploratory Data Analysis
################################################################################
## Peer-graded Assignment 1
################################################################################
rm(list = ls())
setwd("./ExData_Plotting1")
library(dplyr)
################################################################################

temp <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, temp)
#download.file(fileUrl, "./data/power_consumption.zip")
powerdata <- read.table(unz(temp, "household_power_consumption.txt"), 
                        sep = ";", header = TRUE, na.strings = "?", row.names = NULL, 
                        colClasses = c("character", "character", "numeric", 
                                       "numeric", "numeric", "numeric",
                                       "numeric", "numeric", "numeric"))
unlink(temp)

head(powerdata)
str(powerdata)
summary(powerdata)

# subset for needed dates
powerdata <- filter(powerdata, Date ==  "1/2/2007" | Date == "2/2/2007")

# change date and time format
powerdata$datetime <- as.POSIXct(paste(powerdata$Date, powerdata$Time), format="%d/%m/%Y %H:%M:%S")

# check for na's
all(colSums(is.na(powerdata))==0) 


# Plot 4
png(file = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfrow = c(2, 2))
with(powerdata, {
    plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power", pch = ".")
    lines(datetime, Global_active_power)
    
    plot(datetime, Voltage, xlab = "datetime", ylab = "Voltage", pch = ".")
    lines(datetime, Voltage)
    
    with(powerdata, plot(datetime, Sub_metering_1, pch = ".", col = "black",
                         xlab = "", ylab = "Energy sub metering"))
    with(powerdata, lines(datetime, Sub_metering_1, col = "black"))
    with(powerdata, points(datetime, Sub_metering_2, pch = ".", col = "red"))
    with(powerdata, lines(datetime, Sub_metering_2, col = "red"))
    with(powerdata, points(datetime, Sub_metering_3, pch = ".", col = "blue"))
    with(powerdata, lines(datetime, Sub_metering_3, col = "blue"))
    legend("topright", inset = .01, box.lty = 0, lty = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(datetime, Global_reactive_power, pch = ".")
    lines(datetime, Global_reactive_power)
})
dev.off()