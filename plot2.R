plot2 <- function() {
  
  # reading data from a CSV file. read.csv function will only read data for 
  # 2007-02-01 and 2007-02-02.
  file <- "household_power_consumption.txt"
  header <- read.csv(file, sep = ";", header = TRUE,
                   na.strings = "?", stringsAsFactors = FALSE, nrows = 1)
  data <- read.csv(file, sep = ";", na.strings = "?", stringsAsFactors = FALSE,
                   skip = 66636, nrows = 2880)
  
  # assign header names to acquired dataFrame
  names(data) <- names(header)
  
  # converting date and time strings to DateTime POSIXct
  dateTime <- paste(data$Date, data$Time)
  dateTime <- strptime(dateTime, "%d/%m/%Y %H:%M:%S")
  data <- cbind(dateTime, data)
  names(data)[1] <- "datetime"
  
  #initialize .png graphics device - transparent background, cairo type for anti-aliasing
  png("plot2.png", bg = "transparent", type="cairo", width = 480, height = 480, units = "px")
  
  #plot Global_active_power over datetime variable; type = "l" for line
  plot(data$datetime, data$Global_active_power, type="l", 
       xlab = "", ylab = "Global Active Power (kilowatts)")
  
  # release graphics device
  dev.off()
}