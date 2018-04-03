### Module 4 : Exploratory Data Analysis
### Course Project 2
### Part 5:
### Hypothesis: How have emissions from motor vehicle sources 
### changed from 1999-2008 in Baltimore City?

library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIsub <- NEI %>% filter(fips == 24510) %>% select(year, SCC, Emissions)
SCCsub <- select(SCC, SCC, Short.Name)
NEISCC<- merge(NEIsub, SCCsub, by="SCC")

# Subsets motor vehicle sources
vehicle <- grepl("vehicles", NEISCC$Short.Name, ignore.case=TRUE)
MotorVehicle <- NEISCC[vehicle, ]

ggplot(MotorVehicle, aes(factor(year), Emissions)) +
        geom_bar(stat="identity", fill = "#FFD24D") +
        labs (x="Year", y=expression("Total PM"[2.5]*" Emission(Tons)")) +
        labs (title= expression("PM"[2.5]*" from Motor Vehicle Emissions in Baltimore City, 1999-2008"))

dev.copy(png, "plot5.png") #created PNG file
dev.off()

### From 1999 to 2002, emissions from motor vehicles in Baltimore City decreases
### significantly. In the following years, 2005 and 2008, the decrease became gradual.