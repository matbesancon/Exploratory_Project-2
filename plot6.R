# Loading the data
part_data=readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting data from Baltimore and Los Angeles County
two_cities_data<-subset(part_data,(fips=="24510")|(fips=="06037"))
