### Module 4 : Exploratory Data Analysis
### Course Project 2
### Part 4:
### Hypothesis: Across the United States,
### how have emissions from coal combustion-related sources changed from 1999-2008?

library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIsub <- select(NEI, year, fips, SCC, Emissions)
SCCsub <- select(SCC, SCC, Short.Name)
NEISCC<- merge(NEIsub, SCCsub, by="SCC")

# Subsets coal-combustion related sources
coalcombust <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
CoalComb <- NEISCC[coalcombust, ]

ggplot(CoalComb, aes(factor(year), Emissions)) +
        geom_bar(stat="identity", fill = "#BFFF80") +
        labs (x="Year", y=expression("Total PM"[2.5]*" Emission(Tons)")) +
        labs (title= expression("PM"[2.5]*" Emissions From Coal Combustion-related sources in 1999-2008"))

dev.copy(png, "plot4.png") #created PNG file
dev.off()


### Across the US, emissions from coal combustion-related sources were seen to have
### decreased from 1999 to 2008. But it can be observed that the decreased from 1999 to 2005 is very
### minimal, while in 2008 the decrease is significant.