
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
png(file = "plot2.png",bg="transparent",width=480,height=480)

#plot a line chart with data
plot(hpcSub$convDT,hpcSub$Global_active_power,type="l",xlab="",ylab="Global Active Power (killowatts)")

## clean up
dev.off()