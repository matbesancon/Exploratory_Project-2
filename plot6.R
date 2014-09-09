library(ggplot2)

# Loading the data
part_data=readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting data from Baltimore and Los Angeles County
two_cities_data<-subset(part_data,(fips=="24510")|(fips=="06037"))

# Subsetting the SCC data including the words "Motor vehicle" in the short name into 'sub_car'
index_car<-which(grepl('Motor',SCC$Short.Name)==TRUE)
sub_car<-SCC[index_car,]

#Subsetting the cities' data emissions from motor vehicles
car_data<-two_cities_data[which(two_cities_data$SCC%in%sub_car$SCC),]
agg_car<-aggregate(Emissions~year+fips,data=car_data,FUN=sum)
agg_car$City<-NA
for (i in 1:length(agg_car[,1])){
        if (agg_car[i,2]=="24510"){
                agg_car[i,4]<-"Baltimore"
        }else{agg_car[i,4]<-"Los Angeles"}
} 

p<-ggplot(data=agg_car,aes(year,Emissions,colour=factor(City)))
p<-p+geom_point(size=4,shape=7)
p<-p+geom_line(size=0.8)
p<-p+facet_grid(fips~.,scales="free_y")

png(filename='plot6.png')
p
dev.off()
