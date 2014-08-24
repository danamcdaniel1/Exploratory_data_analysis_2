scan.nei <- function() {readRDS("summarySCC_PM25.rds")}
scan.scc <- function() {readRDS("Source_Classification_Code.rds")}

#nei <- scan.nei()
#scc <- scan.scc()

baltimore.emissions   <- nei[ nei$fips == "24510", "Emissions"]
baltimore.years       <- nei[ nei$fips == "24510", "year"]
baltimore.avg         <- as.numeric(by(baltimore.emissions, baltimore.years, mean))
avg.years             <- c(1999, 2002, 2005, 2008)
	
	#create regression model
trend.pm25 <- lm( baltimore.emissions ~ baltimore.years)

	#
	# plot Baltimore fine particulates by year, log scaled
	#
par(mar = c(8.1, 4.1, 4.1, 2.1))
png("plot2.png")
plot( baltimore.years,  baltimore.emissions,
	
	xlab = "Year",
	ylab = "2.5 um particulate emissions (tons, log scale)",
	main = "Fine particulate emissions in Baltimore (1998 - 2008)",
	#log = "y",
	type = "n",
	ylim = c(0, 50)
	)
abline(trend.pm25,
	lty = 2,
	col = rgb(0, .3, 0.4, 0.5),
	)
points( baltimore.years,  baltimore.emissions,
	col = rgb(.05, .7, 1, 0.15),
	pch = 1,
)
mtext("note: y-axis adjusted for improved resolution.  Several outliers not seen.",
 	cex = 0.75,
 	side = 1,
 	line = 4,)
dev.off()