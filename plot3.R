plot3 <- function() {
  if(!is.element("sqldf", installed.packages()[,1])){install.packages("sqldf")}
  library(sqldf)
fileName <- "household_power_consumption.txt"
hpcData <- read.csv.sql(fileName, sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")
dateTime <- paste(hpcData$Date, hpcData$Time, sep = " ")
convData <- cbind(dateTime, hpcData[,3:9])
convData$dateTime <- strptime(convData$dateTime, format = "%d/%m/%Y %T")
convData <- cbind(weekdays(convData$dateTime), convData)


png(filename = "plot3.png", width = 480, height = 480, units = "px")
with(convData, plot(dateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering"))
with(convData, points(dateTime, Sub_metering_2, type = "l", col = "red"))
with(convData, points(dateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), 
       col = c("black", "red", "blue"), lty = 1)

dev.off()
msg <- "Plot3.png created"
msg
}

