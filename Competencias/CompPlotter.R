args <- commandArgs(T)

dat <- read.table(args[1])
Time <- as.numeric(args[2])
cepa<- args[3]

blueth <- rgb(66/255,133/255,244/255)
orangeth <- rgb(255/255,87/255,34/255)

filen <- gsub(".txt", ".png", args[1])
png(filen, width=672*2, height=672, units="px")
par(mfrow=c(4,1))
par(cex = 0.7)
par(mar=c(0.2,0.2,0.2,0.2), oma=c(5.1,5.1,5.1,4.1), las=1)
par(mgp = c(2, 0.6, 0))

plot(dat$V1/60, dat$V2, type="l", xlim=c(0,2*Time), ylim=c(-0.03, 0.26), xaxt="n")
lines(0:Time,rep(-0.02, Time+1), col=blueth, lwd=3)
lines(Time:(2*Time),rep(-0.02, Time+1), col=orangeth, lwd=3)
axis(side=1, labels=F)

plot(dat$V1/60, dat$V3, type="l", xlim=c(0,2*Time), ylim=c(-0.03, 0.26), xaxt="n")
lines(0:Time,rep(-0.02, Time+1), col=blueth, lwd=3)
lines(Time:(2*Time),rep(-0.02, Time+1), col=orangeth, lwd=3)
axis(side=1, labels=F)
axis(side=2, labels=F)

plot(dat$V1/60, dat$V4, type="l", xlim=c(0,2*Time), ylim=c(-0.03, 0.26), xaxt="n")
lines(0:Time,rep(-0.02, Time+1), col=blueth, lwd=3)
lines(Time:(2*Time),rep(-0.02, Time+1), col=orangeth, lwd=3)
axis(side=1, labels=F)
axis(side=2, labels=F)

plot(dat$V1/60, dat$V5, type="l", xlim=c(0,2*Time), ylim=c(-0.03, 0.26))
lines(0:Time,rep(-0.02, Time+1), col=blueth, lwd=3)
lines(Time:(2*Time),rep(-0.02, Time+1), col=orangeth, lwd=3)
axis(side=2, labels=F)

mtext("h", side = 1, outer = TRUE, cex = 1, line = 2.2)
mtext("OD", side = 2, outer = TRUE, cex = 1, line = 2.2)
mtext(cepa, side = 3, outer = TRUE, cex = 1.7, line = 2.2)
dev.off()

