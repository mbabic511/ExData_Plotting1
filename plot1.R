plot1 <- function() {
  
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
  png("plot1.png", bg = "transparent", type="cairo", width = 480, height = 480, units = "px")
  
  # draw histogram to the GD
  hist(data$Global_active_power, 
       col="red", 
       xlab = "Global Active Power (kilowatts)", 
       main = "Global Active Power" )
  
  # release graphics device
  dev.off()
}