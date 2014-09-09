# Loading the data
part_data=readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting data from Baltimore and Los Angeles County
two_cities_data<-subset(part_data,(fips=="24510")|(fips=="06037"))

# Subsetting the SCC data including the words "Motor vehicle" in the short name into 'sub_car'
index_car<-which(grepl('Motor',SCC$Short.Name)==TRUE)
sub_car<-SCC[index_car,]

#Subsetting the Baltimore data emissions from motor vehicles
car_data<-two_cities_data[which(balti_data$SCC%in%sub_car$SCC),]
