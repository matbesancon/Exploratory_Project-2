# Loading ggplot2
library(ggplot2)

# Loading the data
part_data=readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting the SCC data including the word "Coal-fired" in the short name into 'sub_coal'
index_coal<-which(grepl('Coal-fired',SCC$Short.Name)==TRUE)
sub_coal<-SCC[index_coal,]

# Subsetting the particle emissions data
coal_data<-part_data[which(part_data$SCC%in%sub_coal$SCC),]

# Aggregating the emissions per year
attach(coal_data)
agg_coal<-aggregate(Emissions,list(year),FUN=sum)
detach(coal_data)

# Plotting the emissions
png(filename='plot4.png')
qplot(agg_coal[,1],agg_coal[,2],ylim=c(0,NA),main='Coal combustion related emissions in the US',xlab="Year",ylab="Particle emissions (T)",size=5)+geom_line(colour='red',size=0.5)
dev.off()


