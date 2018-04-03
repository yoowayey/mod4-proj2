### Module 4 : Exploratory Data Analysis
### Course Project 2
### Part 2:
### Hypothesis: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

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

### Looking at the plot, we cannot say that the total emissions decreased in Baltimore City
### from 1999 to 2008 because it is shown to be fluctuating. That is, there was a decrease from 1999 to 2002
### then an increase by 2005, followed by a decrease in 2008.