## Check to ensure required packages are installed

require(dplyr)
require(lubridate)

## Download data file(s)

if(!file.exists("./data")){dir.create("./data")}
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/Electronic-power-consumption.zip")

## Check to ensure data was downloaded

ifelse(file.exists("./data/Electronic-power-consumption.zip"), "Download successful", "Download failed")

## Unzip and load data

dl = unzip(zipfile = "./data/Electronic-power-consumption.zip", exdir = "./data")
dt.Raw = read.table(dl, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

## Filter data to pull only 2007-02-01 & 2007-02-02

dt.Trim = dt.Raw[dt.Raw$Date %in% c("1/2/2007","2/2/2007") ,]

## Create new column that combines date & time

dt.Trim$dateTime = paste(dt.Trim$Date, dt.Trim$Time)

## Correct column classes

dt = transform(dt.Trim, Global_active_power = as.numeric(Global_active_power), 
               Global_reactive_power = as.numeric(Global_reactive_power),
               Voltage = as.numeric(Voltage),
               Global_intensity = as.numeric(Global_intensity),
               Sub_metering_1 = as.numeric(Sub_metering_1),
               Sub_metering_2 = as.numeric(Sub_metering_2),
               Sub_metering_3 = as.numeric(Sub_metering_3),
               dateTime = as.POSIXct(dateTime, format = "%d/%m/%Y %H:%M:%S")
)

## Create & save histogram

png('Plot1.png', width = 480, height = 480)
hist(dt$Global_active_power, col = "red", main = "Global Active Power", xlab = "Gloabl Active Power (kilowatts)", ylab = "Frequency")
dev.off()

## Print histogram

hist(dt$Global_active_power, col = "red", main = "Global Active Power", xlab = "Gloabl Active Power (kilowatts)", ylab = "Frequency")
