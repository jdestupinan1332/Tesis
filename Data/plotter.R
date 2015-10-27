args <- commandArgs(T)

dat <- read.table(args[1])
Time <- as.numeric(args[2])

blue <- c(66,133,244)/255
orange <- c(255,87,34)/255

filen <- gsub(".txt", ".png", args[1])

png(paste("Ch1",filen), width=672*2, height=672, units="px")
par(cex=1.5)
plot(dat$V1/60, dat$V2, type="l", main="C1", xlab="h", ylab="OD", ylim=c(-0.03, 0.3))
i <- 0
while (i < (24*7/Time)){
	print (i)
	if (i %% 2 == 0){
		lines((i*Time):((i+1)*Time),rep(-0.02, Time+1), col=rgb(blue[1], blue[2], blue[3]), lwd=3)
	}
	else {
		lines((i*Time):((i+1)*Time),rep(-0.02, Time+1), col=rgb(orange[1],orange[2],orange[3]), lwd=3)
	}
i <- i+1
}
dev.off()

png(paste("Ch2",filen), width=672*2, height=672, units="px")
plot(dat$V1/60, dat$V3, type="l", main="C2", xlab="h", ylab="OD", ylim=c(-0.03, 0.3))
i <- 0
while (i < (24*7/Time)){
	print (i)
	if (i %% 2 == 0){
		lines((i*Time):((i+1)*Time),rep(-0.02, Time+1), col=rgb(blue[1], blue[2], blue[3]), lwd=3)
	}
	else {
		lines((i*Time):((i+1)*Time),rep(-0.02, Time+1), col=rgb(orange[1],orange[2],orange[3]), lwd=3)
	}
i <- i+1
}
dev.off()

png(paste("Ch3",filen), width=672*2, height=672, units="px")
plot(dat$V1/60, dat$V4, type="l", main="C3", xlab="h", ylab="OD", ylim=c(-0.03, 0.3))
i <- 0
while (i < (24*7/Time)){
	print (i)
	if (i %% 2 == 0){
		lines((i*Time):((i+1)*Time),rep(-0.02, Time+1), col=rgb(blue[1], blue[2], blue[3]), lwd=3)
	}
	else {
		lines((i*Time):((i+1)*Time),rep(-0.02, Time+1), col=rgb(orange[1],orange[2],orange[3]), lwd=3)
	}
i <- i+1
}
dev.off()

png(paste("Ch4",filen), width=672*2, height=672, units="px")
plot(dat$V1/60, dat$V5, type="l", main="C4", xlab="h", ylab="OD", ylim=c(-0.03, 0.3))
i <- 0
while (i < (24*7/Time)){
	print (i)
	if (i %% 2 == 0){
		lines((i*Time):((i+1)*Time),rep(-0.02, Time+1), col=rgb(blue[1], blue[2], blue[3]), lwd=3)
	}
	else {
		lines((i*Time):((i+1)*Time),rep(-0.02, Time+1), col=rgb(orange[1],orange[2],orange[3]), lwd=3)
	}
i <- i+1
}
dev.off()

