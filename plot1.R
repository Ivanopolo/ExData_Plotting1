plot1 <- function(){
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
        
        ##Plotting the data the PNG graphical device
        png("plot1.png")
        with(data, hist(Global_active_power, col = "red", 
                        xlab = "Global Active Power (kilowatts)",
                        main = "Global Active Power"))
        dev.off()
}