library(ggplot2)
scan.nei <- function() {readRDS("summarySCC_PM25.rds")}
scan.scc <- function() {readRDS("Source_Classification_Code.rds")}

nei <- scan.nei()
scc <- scan.scc()

# Coal combustion related sources
scc.coal = scc[grepl("coal", scc$Short.Name, ignore.case=TRUE),]

# combine data
merge <- merge( x = nei, y = scc.coal, by = "SCC")
merge.data <- aggregate( merge[, "Emissions"], by=list(merge$year), sum)
colnames( merge.data) <- c( "Year", "Emissions")

# create plot
png( "plot4.png")
ggplot(data = merge.data, 
	aes(x = Year, y = Emissions/1000)) + 
    	geom_smooth(method = "lm") + geom_point(colour = "purple") + 
    	geom_line(color = "purple") + 
	ggtitle("Coal-based fine particulate emissions") + 
   	ylab("2.5 um particulate emissions (kilotons)") + 
    	geom_text(aes(label = round(Emissions/1000, digits = 0),
		size = 1, hadjust = 10, vadjust = 10)) + 
    	theme(legend.position = "none") + 
	theme_bw()

dev.off()
