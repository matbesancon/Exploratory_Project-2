# Loading the data files
part_data=readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting the data from Baltimore
balti_data<-subset(part_data,fips=="24510")

# Subsetting the SCC data including the words "Motor vehicle" in the short name into 'sub_car'
index_car<-which(grepl('Motor',SCC$Short.Name)==TRUE)
sub_car<-SCC[index_car,]

#Subsetting the Baltimore data emissions from motor vehicles
car_data<-balti_data[which(balti_data$SCC%in%sub_car$SCC),]

# Aggregating the car data per year 
attach(car_data)
agg_car<-aggregate(Emissions,list(year),FUN=sum)
detach(car_data)

# Plotting with bar plot
png(filename='plot5.png')
barplot(agg_car[,2],names.arg=(agg_car[,1]),xlab='Year',ylab='Emissions (T)',main='Particle Emissions from motor vehicles in Baltimore')
dev.off()