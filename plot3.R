# Loading the data
part_data=readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Loading the ggplot2 library
library(ggplot2)
library(extraGrid)

# Extracting the data for Baltimore
balti_data<-subset(part_data,fips=="24510")

# Extracting each type of the Baltimore data
sub_point<-subset(balti_data,type=='POINT')
sub_non_point<-subset(balti_data,type=='NONPOINT')
sub_onroad<-subset(balti_data,type=='ON-ROAD')
sub_non_road<-subset(balti_data,type=='NON-ROAD')

# Aggregating emissions for each subset per year
agg_point<-aggregate(sub_point$Emissions,list(sub_point$year),FUN=sum)
agg_non_point<-aggregate(sub_non_point$Emissions,list(sub_non_point$year),FUN=sum)
agg_onroad<-aggregate(sub_onroad$Emissions,list(sub_onroad$year),FUN=sum)
agg_non_road<-aggregate(sub_non_road$Emissions,list(sub_non_road$year),FUN=sum)

plot_point<-qplot(Group.1,x,main="Particle emissions for Point",data=agg_point,xlab="Year",ylab="Particle emissions (T)",geom=c("point","line")) +geom_line()
plot_non_point<-qplot(Group.1,x,main="Particle emissions for Non-Point",data=agg_non_point,xlab="Year",ylab="Particle emissions (T)",geom=c("point","line"))+geom_line()
plot_onroad<-qplot(Group.1,x,main="Particle emissions for On-Road",data=agg_onroad,xlab="Year",ylab="Particle emissions (T)",geom=c("point","line"))+geom_line()
plot_non_road<-qplot(Group.1,x,main="Particle emissions for Point",data=agg_non_road,xlab="Year",ylab="Particle emissions (T)",geom=c("point","line"))+geom_line()

#Creating a PNG file
png(filename='plot3.png')
# Plotting the 4 different types per year
grid.arrange(plot_point,plot_non_point,plot_onroad,plot_non_road,cols=2)

dev.off()

