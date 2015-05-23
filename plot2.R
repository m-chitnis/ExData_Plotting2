## R Programming assignment Exploratory Data Analysus Course Project # 2
## Author: M. Chitnis
## Date: May22, 2015
## Filename: plot2.R

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

## Calculate aggregate by year for Baltimore City, Maryland (fips == "24510") 
aggregateByYearBal <- aggregate(Emissions ~ year, subset(NEI,fips=="24510"), sum)

## Open png device with width=480, height=480
png(filename="plot2.png", width = 480, height = 480, units = "px", bg="white")

## Make plot
plot(aggregateByYearBal$year, aggregateByYearBal$Emissions, type="b", xlab="Year", ylab="Total Emissions")
title(main = "Baltimore City PM 2.5 Data (1999-2008)")

## Turn Off device
dev.off()