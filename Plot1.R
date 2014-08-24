scan.nei <- function {
	readRDS("summarySCC_PM25.rds")
}

scan.scc <- function {
	readRDS("Source_Classification_Code.rds")
}

log.nei.emissions <- log(nei$Emissions)

trend.pm25 <- lm( log.nei.emissions ~ nei$year)

plot(nei$year, log.nei.emissions,
	col = rgb(1, 0, 1, 0.5),
	xlab = "Year",
	ylab = "small particulate emissions (tons, log scale)",
	main = "Fine particulates emissions (1998 - 2008)",
	)

abline(trend.pm25,
	lty = 2,
	col = rgb(1, 0, 0.5, 0.5),
	)