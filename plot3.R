## R Programming assignment Exploratory Data Analysus Course Project # 2
## Author: M. Chitnis
## Date: May22, 2015
## Filename: plot3.R

library(ggplot2)

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

## Get data for Baltimore City, Maryland (fips == "24510") 
NEIBal <- subset(NEI, fips=="24510")


## Open png device with width=480, height=480
png(filename="plot3.png", width = 480, height = 480, units = "px", bg="white")

## Use ggplot to plot the data
ggBal <- ggplot(NEIBal, aes(x = factor(year), y = Emissions, fill=type)) + 
  geom_bar(stat ="identity") + 
  facet_grid(.~type) + 
  labs(x="Year", y="Emissions") +
  labs(title= "Baltimore City PM 2.5 by Source Type (1999-2008)")

print(ggBal)

## Turn Off device
dev.off()