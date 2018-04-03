## Question 1 ([plot1.R](https://github.com/yoowayey/mod4-proj2/blob/master/plot1.R))

Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the **base** plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
```
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$year <- as.factor(NEI$year)

pmAll <- NEI %>% group_by(year) %>% summarize(total = sum(Emissions))
with(pmAll, barplot(total, names = pmAll$year,
                          main = "Total Emission in the United States, 1999-2008", 
                          xlab = "Year",
                          ylab = "Total Emission"))

dev.copy(png, "plot1.png") #created PNG file
dev.off()
````
![plot1.PNG](https://github.com/yoowayey/mod4-proj2/blob/master/plot1.png)

Conclusion: The total emissions from PM2.5 from 1999 to 2008 is observed to have decreased.

## Question 2 ([plot2.R](https://github.com/yoowayey/mod4-proj2/blob/master/plot2.R))

Have total emissions from PM2.5 decreased in the **Baltimore City**, Maryland (**`fips == "24510"`**) from 1999 to 2008? Use the **base** plotting system to make a plot answering this question.
```
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips <- as.integer(NEI$fips)
NEI$year <- as.factor(NEI$year)

pmBaltimore <- NEI %>% filter(fips == 24510) %>% group_by(year) %>% summarize(total = sum(Emissions))
with(pmBaltimore, barplot(total, names = pmBaltimore$year,
                 main = "Total Emission in Baltimore, Maryland, 1999-2008", 
                 xlab = "Year",
                 ylab = "Total Emission"))
dev.copy(png, "plot2.png") #created PNG file
dev.off()
```
![plot2.PNG](https://github.com/yoowayey/mod4-proj2/blob/master/plot2.png)

Conclusion: Looking at the plot, we cannot say that the total emissions decreased in Baltimore City from 1999 to 2008 because it is shown to be fluctuating. That is, there was a decrease from 1999 to 2002 then an increase by 2005, followed by a decrease in 2008.

## Question 3 ([plot3.R](https://github.com/yoowayey/mod4-proj2/blob/master/plot3.R))

Of the four types of sources indicated by the **`type`** (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for **Baltimore City**? Which have seen increases in emissions from 1999–2008? Use the **ggplot2** plotting system to make a plot answer this question.
```
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
```
![plot3.PNG](https://github.com/yoowayey/mod4-proj2/blob/master/plot3.png)

Conclusion: Non-road, nonpoint, and on-road sources were seen to have decreased signficantly through time. But for the point type, an increase can be observed from 1999 to 2005, then eventually decreased significantly by 2008.

## Question 4 ([plot4.R](https://github.com/yoowayey/mod4-proj2/blob/master/plot4.R))

Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
```
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
```
![plot4.PNG](https://github.com/yoowayey/mod4-proj2/blob/master/plot4.png)

Conclusion: Across the US, emissions from coal combustion-related sources were seen to have decreased from 1999 to 2008. But it can be observed that the decreased from 1999 to 2005 is very minimal, while in 2008 the decrease is significant.

## Question 5 ([plot5.R](https://github.com/yoowayey/mod4-proj2/blob/master/plot5.R)

How have emissions from motor vehicle sources changed from 1999–2008 in **Baltimore City**?
```
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
```
![plot5.PNG](https://github.com/yoowayey/mod4-proj2/blob/master/plot5.png)

Conclusion: From 1999 to 2002, emissions from motor vehicles in Baltimore City decreased significantly. But in the following years, 2005 and 2008, the decrease became gradual.

## Question 6 ([plot6.R](https://github.com/yoowayey/mod4-proj2/blob/master/plot6.R))

Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in **Los Angeles County**, California (**`fips == "06037"`**). Which city has seen greater changes over time in motor vehicle emissions?
```
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
```
![plot6.PNG](https://github.com/yoowayey/mod4-proj2/blob/master/plot6.png)

Conclusion: Los Angles County has seen greater changes over time in motor vehicle emissions than Baltimore City.
