# Exploratory Data Analysis

**Project 1**  
For a description of the instructions of project 1, see the instructor repository [here](https://github.com/rdpeng/ExData_Plotting1). The source data is quite large and exceeds GitHub's file size limitations, but can be found [here](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip) as originally sourced from the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/).

**Project 2**  
Project 2 involves using the exploratory data analysis techniques, specifically data visualization to answer questions from provided data. This project focuses on fine particulate matter, aka PM2.5, that is found in the air we breathe. The data can be found in the repository, or at the link [here](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip) and it is originally sourced from the [EPA National Emissions Inventory site](https://www.epa.gov/technical-air-pollution-resources).

The questions asked and my respective answers, are found below

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the **base** plotting system, make a plot showing the *total* PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

   > Plot 1: Yes. We can see a clear declining trend in the overall emissions when looking at the entire United States.

2. Have total emissions from PM2.5 decreased in the **Baltimore City**, Maryland (fips == "24510") from 1999 to 2008? Use the **base** plotting system to make a plot answering this question.

   > Plot 2: Yes. Again, we see the decline. Baltimore is interesting relative to our results from question 1. Instead of a more liner path, Baltimore emissions spiked back up in 2005 before declining to lows in 2008.

3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for **Baltimore City**? Which have seen increases in emissions from 1999–2008? Use the **ggplot2** plotting system to make a plot answer this question.

   > Plot 3: Of the four sources in Baltimore the following three have declined in emissions: non-road, non-point, and on-road from 1999-2008. Only one type, point, has increased over the same period in Baltimore.

4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

   >Plot 4: When looking at coal combustion-related source over the time period in the entire United States, we see a decline, with a steep decrease from the 2005 point to the 2008 point.

5. How have emissions from motor vehicle sources changed from 1999–2008 in **Baltimore City**?

   >Plot 5: Emissions from motor vehicle sources in Baltimore have decreased rapidly from 1999 to 2002 but have decreased moderately since 2002.

6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in **Los Angeles County**, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

   >Plot 6: When comparing Los Angeles and Baltimore, we see that Baltimore has lower motor vehicle related emissions in total. This could be due to the fact that Baltimore is clearly a less populated and less congested area relative to Los Angeles. Los Angeles has seen greater fluctuations compared to Baltimore, and has even risen in 2008 compared to 2002 levels. Overall, in terms of total change, Los Angeles has a greater change from 1999 to 2008 with a decrease of approximately 250 tons whereas Baltimore has decreased by approximately 80 tons over the same period. to explore further, it may be worth it to adjust for population to make the comparison a bit more apples-to-apples.



---
Feel free to check out my personal blog at [jedraynes.com](https://www.jedraynes.com). There, you can find ways to contact me via a contact form or over [LinkedIn](https://www.linkedin.com/in/jedraynes/).

jedraynes
