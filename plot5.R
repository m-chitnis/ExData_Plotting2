## R Programming assignment Exploratory Data Analysus Course Project # 2
## Author: M. Chitnis
## Date: May22, 2015
## Filename: plot5.R

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

## Open png device with width=480, height=480
png(filename="plot5.png", width = 480, height = 480, units = "px", bg="white")

## Make barplot
barplot(height=aggregateByYearBalVeh$Emissions, names.arg=aggregateByYearBalVeh$year,
        main='US PM 2.5 Motor Vehicle Data for Baltimore(1999-2008)', 
        xlab='Year', ylab='Emissions', col='gray') 


## Turn Off device
dev.off()
