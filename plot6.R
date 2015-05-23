## R Programming assignment Exploratory Data Analysus Course Project # 2
## Author: M. Chitnis
## Date: May22, 2015
## Filename: plot6.R

## Download and read file if not already done
if (!exists("NEI")) {
  workDir <- getwd()
  setwd("..")
  
  ## download and unzip file  
  remoteFile="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  
  download.file(remoteFile,
                method="curl",
                destfile="exdata-data-NEI_data.zip")  
  
  unzip("exdata-data-NEI_data.zip")  
  
  ## read RDS file
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds") 
  
  setwd(workDir)
}

## Get SCCs for Motor Vehicle
SCCvehicle <- SCC[grep("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE), ]$SCC

vehicleNEI <- NEI[NEI$SCC %in% SCCvehicle,]

## Calculate aggregate by year for Baltimore City, Maryland (fips == "24510") 
aggregateByYearBalVeh <- aggregate(Emissions ~ year, subset(NEI,fips=="24510"), sum)

## Calculate aggregate by year for Los Angeles County, California (fips == "06037"
aggregateByYearLAVeh <- aggregate(Emissions ~ year, subset(NEI,fips=="06037"), sum)

## Open png device with width=480, height=480
png(filename="plot6.png", width = 480, height = 480, units = "px", bg="white")

## Make plot
par(mfrow=c(1,2))

## Baltimore
plot(x=aggregateByYearBalVeh$year, y=aggregateByYearBalVeh$Emissions, 
        xlab='Year', ylab='Baltimore Emissions', type="b")

title(main = "Baltimore PM 2.5 Data")

## Los Angeles
plot(x=aggregateByYearLAVeh$year, y=aggregateByYearLAVeh$Emissions, 
     xlab='Year', ylab='LA Emissions', type="b")

title(main = "Los Angeles PM 2.5 Data")

## Turn Off device
dev.off()
