plot3 <- function() {
  
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
  
  #initialize .png graphics device - transparent background, cairo type for anti-aliasing,
  #dimenisions as in given example plot
  png("plot3.png", bg = "transparent", type="cairo", width = 504, height = 504, units = "px")
  
  # initialize a plot and draw lines for Sub_metering_1
  plot(data$datetime, data$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
  
  # draw lines for Sub_metering_2
  points(data$datetime, data$Sub_metering_2, type="l", col="red")
  
  # draw lines for Sub_metering_3
  points(data$datetime, data$Sub_metering_3, type="l", col="blue")
  
  # generate a legend
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col=c("black", "red", "blue"), lty=c(1,1,1), lwd=c(1,1,1))
  
  # release graphics device
  dev.off()
}