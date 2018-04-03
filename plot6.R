### Module 4 : Exploratory Data Analysis
### Course Project 2
### Part 6:
### Compare emissions from motor vehicle sources in Baltimore City
### with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
### Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)
library(RColorBrewer)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips <- as.integer(NEI$fips)
SCCsub <- select(SCC, SCC, Short.Name)

pmLACounty <- unique(subset(NEI, fips == 06037, c(year, SCC, Emissions)))
pmLACounty<- merge(pmLACounty, SCCsub, by="SCC")
pmBaltimore <- unique(subset(NEI, fips == 24510, c(year, SCC, Emissions)))
pmBaltimore<- merge(pmBaltimore, SCCsub, by="SCC")

# Subsets motor vehicle sources
vehicle1 <- grepl("vehicles", pmLACounty$Short.Name, ignore.case=TRUE)
pmLA_mv <- pmLACounty[vehicle1, ]

vehicle2 <- grepl("vehicles", pmBaltimore$Short.Name, ignore.case=TRUE)
pmBC_mv <- pmBaltimore[vehicle2, ]

pmLA_mv <- mutate(pmLA_mv, loc = "LA County")
pmBC_mv <- mutate(pmBC_mv, loc = "Baltimore City")

both <- rbind(pmBC_mv, pmLA_mv)

ggplot(both, aes(factor(year), Emissions)) + 
        geom_bar(stat="identity", aes(fill=factor(year)), show.legend=F) +
        scale_fill_brewer(palette="Set2") +
        facet_grid(.~loc) +
        labs (x="Year", y=expression("Total PM"[2.5]*" Emission(Tons)")) +
        labs (title= expression("PM"[2.5]*" from Motor Vehicle Emissions in Baltimore & LA County in 1999-2008"))

dev.copy(png, "plot6.png") #created PNG file
dev.off()


### Answer to question: LA County has seen greater changes over time in motor vehicle emissions