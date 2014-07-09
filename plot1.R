
# to read data from file kept in current working directory
fileName <- "household_power_consumption.txt"
 columnClass <- c("character", "character", "numeric", "numeric", "numeric", "numeric",
                  "numeric", "numeric", "numeric")
 data <- read.table(fileName, header = T, sep = ";", colClasses = columnClass, 
                    nrow = 2075259, comment.char = "", na.strings = "?" )
# na.strings = "?" as missing values are coded as ?
# comment.char = "" as input file has no comments

# Extract data for date 01/02/2007 and 02/02/2007 using vectorization
powerConsumptionData <- data[data[, 1] == "1/2/2007" | data[, 1] == "2/2/2007", ]

# create a histogram in file plot1.png of specified dimension 480 * 480
png("plot1.png", height = 480, width = 480)
hist(powerConsumptionData[,3], main = "Global Active Power", col = "red",
     xlab = "Global Active Power(kilowatts)")
dev.off()
