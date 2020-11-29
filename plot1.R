# reading a few rows to know variable names,from the downloaded file
initial <- read.table("./data/household_power_consumption.txt", sep=";",header=T,
                      nrow=50)
names <- names(initial)
# read the data from just those dates rather than reading in the entire 
library(data.table)
# using fread to read only the "Date" column
date <- fread("./data/household_power_consumption.txt", select="Date")
date <- as.Date(date$Date, "%d/%m/%Y")
# returning dataframe indeces where Date matches that required
day1<- which(date=="2007-02-01")
day2 <- which(date=="2007-02-02")
# number of lines to skip
skip<- min(day1)
# number of lines to read
nrow<- length(day1) + length(day2)
# reading data for dates needed only 
data <- read.table("./data/household_power_consumption.txt", sep=";",header=T,
                    nrows= nrow, skip=skip, col.names = names, 
                    na.strings = c(" ","?"))
# Plot
png(filename="plot1.png", width = 480, height=480)
with(data, hist(Global_active_power, col="red", 
                xlab= "Global Active Power (kilowatts)",main="Global Active Power"))
dev.off()
