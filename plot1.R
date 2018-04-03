### Module 4 : Exploratory Data Analysis
### Course Project 2
### Part 1: 
### Hypothesis: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

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


### The total emissions from PM2.5 from 1999 to 2008 is observed to have decreased.