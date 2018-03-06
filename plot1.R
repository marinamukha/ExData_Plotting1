getwd################################################################################
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

# Plot 1
png(file = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfrow = c(1, 1))
hist(powerdata$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

