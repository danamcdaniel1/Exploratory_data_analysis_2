library(ggplot2)
scan.nei <- function() {readRDS("summarySCC_PM25.rds")}
scan.scc <- function() {readRDS("Source_Classification_Code.rds")}

#nei <- scan.nei()
#scc <- scan.scc()

emissions 	<- nei[ nei$fips == "24510" & nei$type == "ON-ROAD", "Emissions"] 
year	 	<- nei[ nei$fips == "24510" & nei$type == "ON-ROAD", "year"]
onroad.data <- data.frame(c(emissions, year))

# create plot
png( "plot5.png")
ggplot(data = onroad.data, 
	aes(x = year, y = emissions)) + 
    	geom_smooth(method = "lm", colour = "light green", linetype = 2) + 
	geom_point(colour = "dark green", alpha = 0.1, size = 4, shape = 3) +  
	ggtitle("Motor-vehicle fine particulate emissions in Baltimore, MD") + 
   	ylab("2.5 um particulate emissions (tons)") +  
    	theme(legend.position = "none") + 
	theme_bw()

dev.off()
