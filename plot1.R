plot1 <- function() {
  if(!is.element("sqldf", installed.packages()[,1])){install.packages("sqldf")}
  library(sqldf)
fileName <- "household_power_consumption.txt"
hpcData <- read.csv.sql(fileName, sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")
dateTime <- paste(hpcData$Date, hpcData$Time, sep = " ")
convData <- cbind(dateTime, hpcData[,3:9])
convData$dateTime <- strptime(convData$dateTime, format = "%d/%m/%Y %T")
png(filename = "plot1.png", width = 480, height = 480, units = "px")
with(convData, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency"))
dev.off()
msg <- "Plot1.png created"
msg
}

