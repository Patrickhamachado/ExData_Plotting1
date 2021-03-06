# ------------------        Libraries    ---------------
library(plyr)
library(dplyr)

# ------------------        1- File Downloading    ---------------
if (!file.exists( "./data" )) { 
    dir.create( "./data" ) 
}

zipfile = "./data/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if ( !file.exists( zipfile ) ) {
    print( "Dowloading file ..." )
    fileUrl1 = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    print( paste("From" , fileUrl1) )
    download.file( fileUrl1 , destfile = zipfile)
}   else {
    print( "Download file already exists." )
}


# ------------------        2- File Extracting    ---------------
datafile = "./data/household_power_consumption.txt"
if ( !file.exists( datafile ) ) {
    print( "Extracting folder ..." )
    unzip(zipfile , exdir = "./data")
} else {
    print( "Unzipped file already exists." )
}

# ------------------        3- Data reading    ---------------

# To read just the needed data:

# Getting the names:
power_names = read.table(file = datafile, sep = ";" , header = TRUE,
                   na.strings = "?", nrows = 10)

# Getting the dates:
power_dates = read.table(file = datafile, sep = ";" , header = TRUE,
                         na.strings = "?", nrows = 70000,
                         colClasses = c(NA, rep("NULL" , 8)) )

# First interest date:
first = head( which(power_dates == "1/2/2007" ) , 1) 

# Last interest date:
last = tail( which(power_dates == "2/2/2007" ) , 1) + 1

# Reading just the needed data
power = read.table(file = datafile, sep = ";" , header = FALSE,
                   na.strings = "?", nrows = last - first ,
                   skip = first , col.names = names(power_names))


# ------------------        4- Plot 4    ---------------

# time series
timeseries= strptime( paste0(power$Date, " ", power$Time),
                      "%d/%m/%Y %H:%M:%S" ) 

# Four plots
par(mfcol = c(2,2))
# Plot 1
plot( 
    timeseries , power$Global_active_power, type = "l", xlab = "",
    ylab = "Global Active Power"  )


# Plot 2
plot( timeseries, power$Sub_metering_1, type = "l", xlab = "",
      ylab = "Energy sub metering"  ) 

lines( timeseries, power$Sub_metering_2, col = "red" )
lines( timeseries, power$Sub_metering_3, col = "blue" )
legend("topright", legend =
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c( "black", "red", "blue" )
       ,lty = "solid", box.lty = 0 )

# Plot 3
plot( timeseries, power$Voltage, type = "l", xlab = "datetime",
      ylab = "Voltage"  )

# Plot 4
plot( timeseries, power$Global_reactive_power, type = "l",
      xlab = "datetime", ylab = "Global_reactive_power"  )

# ----------------      plot4.png       ---------------------
png(filename = "plot4.png", width = 480, height = 480, units = "px" ) 

# Four plots
par(mfcol = c(2,2))
# Plot 1
plot( 
    timeseries , power$Global_active_power, type = "l", xlab = "",
    ylab = "Global Active Power"  )


# Plot 2
plot( timeseries, power$Sub_metering_1, type = "l", xlab = "",
      ylab = "Energy sub metering"  ) 

lines( timeseries, power$Sub_metering_2, col = "red" )
lines( timeseries, power$Sub_metering_3, col = "blue" )
legend("topright", legend =
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c( "black", "red", "blue" )
       ,lty = "solid", box.lty = 0)

# Plot 3
plot( timeseries, power$Voltage, type = "l", xlab = "datetime",
      ylab = "Voltage"  )

# Plot 4
plot( timeseries, power$Global_reactive_power, type = "l",
      xlab = "datetime", ylab = "Global_reactive_power"  )

dev.off()