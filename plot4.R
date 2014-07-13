plot4 <- function(){
        ##Loading data
        file <- "household_power_consumption.txt"
        
        #Getting names for the columns
        colNames <- read.csv2(file, nrows = 1)
        colNames <- names(colNames)
        
        #Setting rows needed for 1/2/2007 and 2/2/2007
        startRow <- 66638
        lastRow <- 69517
        nrows <- lastRow - startRow + 1
        
        #Setting column classes
        colClasses <- c("character", "character", rep("numeric", 7))
        
        #Reading needed data, setting classes and names for the columns
        data <- read.table(file, header = FALSE, skip = startRow - 1, 
                           nrows = nrows, colClasses = colClasses, sep = ";")
        names(data) <- colNames
        
        #Concatenating Date & Time to get a character vector
        datetime <- paste(data$Date, data$Time, sep = " ")
        
        #Converting character to Date type in R
        datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
        
        #Dropping Date and Time columns, appending the new column to the data
        data$Date <- NULL
        data$Time <- NULL
        data$datetime <- datetime
        
        data
        
        ##Setting the right language locale, 
        ##so that days of the week appear in English
        Sys.setlocale(category = "LC_TIME", locale = "C")
        
        ##Plotting the data the PNG graphical device
        png("plot4.png")
        par(mfcol = c(2, 2), oma = c(1, 0, 0, 0), mar = c(4, 4, 2, 1))
        
        #Plot 1 - Global Active Power by datetime
        with(data, plot(datetime, Global_active_power, type = "n",
                        ylab = "Global Active Power",
                        xlab = ""))
        with(data, lines(datetime, Global_active_power))
        
        #Plot 2 - Energy sub metering by datetime
        with(data, plot(datetime, Sub_metering_1, type = "n",
                        ylab = "Energy sub metering",
                        xlab = ""))
        with(data, lines(datetime, Sub_metering_1))
        with(data, lines(datetime, Sub_metering_2, col = "red"))
        with(data, lines(datetime, Sub_metering_3, col = "blue"))
        legend("topright", lwd = 1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2",
                          "Sub_metering_3"), bty = "n", cex = 0.8)
        
        #Plot 3 - Voltage by datetime
        with(data, plot(datetime, Voltage, type = "n",
                        ylab = "Voltage"))
        with(data, lines(datetime, Voltage))
        
        #Plot 4 - Global reactive power by datetime
        with(data, plot(datetime, Global_reactive_power, type = "n"))
        with(data, lines(datetime, Global_reactive_power))
        
        dev.off()
}