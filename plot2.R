plot2 <- function() {
  if(!is.element("sqldf", installed.packages()[,1])){install.packages("sqldf")}
  library(sqldf)
fileName <- "household_power_consumption.txt"
hpcData <- read.csv.sql(fileName, sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")
dateTime <- paste(hpcData$Date, hpcData$Time, sep = " ")
convData <- cbind(dateTime, hpcData[,3:9])
convData$dateTime <- strptime(convData$dateTime, format = "%d/%m/%Y %T")
convData <- cbind(weekdays(convData$dateTime), convData)
png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(convData, plot(dateTime, Global_active_power, type = "l"))
dev.off()
msg <- "Plot2.png created"
msg
}

