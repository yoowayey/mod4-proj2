### Module 4 : Exploratory Data Analysis
### Course Project 2
### Part 3:
### Hypothesis: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
### which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?

library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

pmBaltimore_type1<- NEI %>% filter(fips == 24510, type == "POINT") %>% group_by(year) 
pmBaltimore_type2<- NEI %>% filter(fips == 24510, type == "NONPOINT") %>% group_by(year) 
pmBaltimore_type3<- NEI %>% filter(fips == 24510, type == "ON-ROAD") %>% group_by(year) 
pmBaltimore_type4<- NEI %>% filter(fips == 24510, type == "NON-ROAD") %>% group_by(year) 

pmBaltimore_type <- NEI %>% filter(fips == 24510) %>% group_by(year) %>% group_by(type)
ggplot(pmBaltimore_type, aes(factor(year), Emissions, fill=type)) + 
        geom_bar(stat="identity", show.legend = F) +
        facet_grid(.~type) +
        labs (x="Year", y=expression("Total PM"[2.5]*" Emission(Tons)")) +
        labs (title= expression("PM"[2.5]*" Emissions in Baltimore City in 1999-2008"))

dev.copy(png, "plot3.png") #created PNG file
dev.off()


### Non-road, nonpoint, and on-road sources were seen to have decreased signficantly 
### through time. But for the point type, an increase can be observed from 1999 to 2005,
### then eventually decreased significantly by 2008.