plot4 <- function() {
  
# We use the SQLDF package to read in only the portion of the
# source package that will be used in the project.
# We specifically use the read.csv.sql function.
# Details on the SQLDF package can be found here: 
# http://cran.r-project.org/web/packages/sqldf/index.html
  
  if(!is.element("sqldf", installed.packages()[,1])){install.packages("sqldf")}
  library(sqldf)

# It is expected that the source file has been unzipped and resides
# in the current working directory
  
  fileName <- "household_power_consumption.txt"
  hpcData <- read.csv.sql(fileName, sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", 
                          header = TRUE, sep = ";")
  
# Concatenate the date and time variables to a single variable

  dateTime <- paste(hpcData$Date, hpcData$Time, sep = " ")
  convData <- cbind(dateTime, hpcData[,3:9])
  
# Convert datetime to the datetime class  

  convData$dateTime <- strptime(convData$dateTime, format = "%d/%m/%Y %T")
  convData <- cbind(weekdays(convData$dateTime), convData)

# Open the png device and write the plots

  png(filename = "plot4.png", width = 480, height = 480, units = "px")
  par(mfrow = c(2,2))

# Plot1  

  with(convData, plot(dateTime, Global_active_power, type = "l", xlab = ""))

# Plot2  
  
  with(convData, plot(dateTime,Voltage , type = "l"))

# Plot3  

  with(convData, plot(dateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering"))
  with(convData, points(dateTime, Sub_metering_2, type = "l", col = "red"))
  with(convData, points(dateTime, Sub_metering_3, type = "l", col = "blue"))
  legend("topright", legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), 
       col = c("black", "red", "blue"), lty = 1)

# Plot4  

  with(convData, plot(dateTime, Global_reactive_power, type = "l"))
  dev.off()

# Return completion message

  msg <- "Plot4.png created"
  msg
}

