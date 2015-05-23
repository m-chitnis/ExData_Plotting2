## R Programming assignment Exploratory Data Analysus Course Project # 2
## Author: M. Chitnis
## Date: May22, 2015
## Filename: plot4.R

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

## Get SCCs for Combustion and Coal combination
SCCcoalcomb <- SCC[grep("comb", SCC$Short.Name, ignore.case=TRUE), ]
SCCcoalcomb <- SCCcoalcomb[grep("coal", SCCcoalcomb$Short.Name, ignore.case=TRUE),]$SCC

coalcommNEI <- NEI[NEI$SCC %in% SCCcoalcomb,]

aggregateByYearCoal <- aggregate(Emissions ~ year, coalcommNEI, sum)

## Open png device with width=480, height=480
png(filename="plot4.png", width = 480, height = 480, units = "px", bg="white")

## Make barplot
barplot(height=aggregateByYearCoal$Emissions, names.arg=aggregateByYearCoal$year,
        main='US PM 2.5 Combustion-Coal Data (1999-2008)', 
        xlab='Year', ylab='Emissions', col='gray') 


## Turn Off device
dev.off()
