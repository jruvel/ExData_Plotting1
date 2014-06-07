
## read in full household powe data from UC Irvine
## set header to true, use ";" as seperator, and set ? to NA
hpcOrig <- read.table("household_power_consumption.txt",header=TRUE, sep=";",na.strings="?",stringsAsFactors = FALSE)

## convert date and time to POSIXlt column
dates <- hpcOrig[,1]
times <- hpcOrig[,2]
datetimes <- paste(dates,times)
convDT <- strptime(datetimes,"%d/%m/%Y %H:%M:%S")

##make a copy of original object
hpcSub <- hpcOrig

##add column to object
hpcSub <- cbind(hpcSub,convDT)

## subset the two days we care about 2/1/2007 and 2/2/2007
hpcSub <- subset(hpcSub,hpcSub$convDT >= as.POSIXlt("2007-02-01 00:00:00"))
hpcSub <- subset(hpcSub,hpcSub$convDT <= as.POSIXlt("2007-02-02 23:59:59"))

## open up a png graphics device
png(file = "plot4.png",bg="transparent",width=480,height=480)

par(mfrow = c(2,2))

##plot top left graph 1
plot(hpcSub$convDT,hpcSub$Global_active_power,type="l",xlab="",ylab="Global Active Power (killowatts)")

##plot top right graph 2
plot(hpcSub$convDT,hpcSub$Voltage,type="l",xlab="datetime",ylab="Voltage")

##plot the bottom left graph 3
plot(hpcSub$convDT,hpcSub$Sub_metering_1,type="s",xlab="",ylab="Energy sub metering")
## add two more sub metering plot
lines(hpcSub$convDT,hpcSub$Sub_metering_2,type="s",col="red")
lines(hpcSub$convDT,hpcSub$Sub_metering_3,type="s",col="blue")
## add legend
legend("topright", lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")

##plot bottom right graph 4
plot(hpcSub$convDT,hpcSub$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

## clean up
dev.off()