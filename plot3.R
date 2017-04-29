## loading the dataset 
power <- read.csv("household_power_consumption.txt", header = TRUE, sep = ';', 
                  na.strings = "?", check.names = FALSE, nrows = 2075259, stringsAsFactors = FALSE, comment.char = "", quote = '\"')
## formatting date column
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

## taking subset of the full dataset 

partial_power <- subset(power, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(power)

## converting date to time
datetime <- paste(as.Date(partial_power$Date), partial_power$Time)
partial_power$Datetime <- as.POSIXct(datetime)

## Plotting 
with(partial_power, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()