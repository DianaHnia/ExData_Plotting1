# reading a few rows to know classes, from the downloaded file
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
png(filename="plot2.png", width = 480, height=480)
p <- paste(data$Date, data$Time, sep=" ")
p <- strptime(p, "%d/%m/%Y %H:%M:%S")
p <- as.POSIXct(p)
data <- data %>% mutate(alltime = p) %>% select(Global_active_power,alltime)
with(data, plot(alltime,Global_active_power, type="l", xlab="",
                 ylab= "Global Active Power (kilowatts)"))
dev.off()

