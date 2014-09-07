# Loading the data
part_data=readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Loading the ggplot2 library
library(ggplot2)
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

#Creating a PNG file
png(filename='plot3.png')

# Plotting the 4 different types per year
par(mfrow=c(2,2))
plot(agg_point$Group.1,agg_point$x,main="Particle emissions for Point",xlab="Year",ylab="Particle emission (T)",pch="+")
lines(agg_point$Group.1,agg_point$x,col="purple")

mtext("Comparison of particle emissions the for types across years ")

plot(agg_non_point$Group.1,agg_non_point$x,main="Particle emissions for Non-Point",xlab="Year",ylab="Particle emission (T)",pch="+")
lines(agg_non_point$Group.1,agg_non_point$x,col="red")

plot(agg_onroad$Group.1,agg_onroad$x,main="Particle emissions for On Road",xlab="Year",ylab="Particle emission (T)",pch="+")
lines(agg_onroad$Group.1,agg_onroad$x,col="blue")

plot(agg_non_road$Group.1,agg_non_road$x,main="Particle emissions for Non-Road",xlab="Year",ylab="Particle emission (T)",pch="+")
lines(agg_non_road$Group.1,agg_non_road$x,col="orange")

dev.off()

