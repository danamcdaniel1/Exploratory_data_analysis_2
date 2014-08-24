library(ggplot2)
scan.nei <- function() {readRDS("summarySCC_PM25.rds")}
scan.scc <- function() {readRDS("Source_Classification_Code.rds")}

#nei <- scan.nei()
#scc <- scan.scc()

# subset data
baltimore.emissions 	<- nei[ nei$fips == "24510" & nei$type == "ON-ROAD", "Emissions"] 
baltimore.years	 	<- nei[ nei$fips == "24510" & nei$type == "ON-ROAD", "year"]
baltimore.avg         <- as.numeric(by(baltimore.emissions, baltimore.years, mean))
LA.emissions 	<- nei[ nei$fips == "06037" & nei$type == "ON-ROAD", "Emissions"] 
LA.years	 	<- nei[ nei$fips == "06037" & nei$type == "ON-ROAD", "year"]
LA.avg		<- as.numeric(by(LA.emissions, LA.years, mean))
year             <- c(1999, 2002, 2005, 2008)

emissions 	<- c(baltimore.avg, LA.avg)
city 		<- gl(2,4, labels = c("Baltimore", "Los Angeles"))
city.data 	<- data.frame( emissions, year, city)


# create plot
png( "plot6.png")
ggplot(data = city.data, aes(x = year, y = emissions)) +  
    	geom_point(aes(size = 4, col = factor(city)))+
	geom_line( aes(col = factor(city))) +
	labs (title = "Fine particulate emissions in Los Angeles, CA and Baltimore, MD")+
	labs (x = "year")+
	labs (y = "2.5 um particulate emissions (tons)")
		

dev.off()
