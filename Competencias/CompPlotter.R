args <- commandArgs(T)

Time <- as.numeric(args[1])
cepa<- args[2]

blue <- c(66,133,244)/255
orange <- c(255,87,34)/255

par(mfrow=c(4,1))
par(cex = 0.7)
par(mar=c(0.2,0.2,0.2,0.2), oma=c(5.1,5.1,5.1,4.1), las=1)
par(mgp = c(2, 0.6, 0))

plot(dat$V1/60, dat$V2, type="l", xlim=c(0,2*Time), ylim=c(-0.03, 0.26), xaxt="n")
lines(0:Time,rep(-0.02, Time+1), col=rgb(blue[1], blue[2], blue[3]), lwd=3)
lines(Time:(2*Time),rep(-0.02, Time+1), col=rgb(orange[1],orange[2],orange[3]), lwd=3)
axis(side=1, labels=F)

plot(dat$V1/60, dat$V3, type="l", xlim=c(0,2*Time), ylim=c(-0.03, 0.26), xaxt="n")
lines(0:Time,rep(-0.02, Time+1), col=rgb(blue[1], blue[2], blue[3]), lwd=3)
lines(Time:(2*Time),rep(-0.02, Time+1), col=rgb(orange[1],orange[2],orange[3]), lwd=3)
axis(side=1, labels=F)
axis(side=2, labels=F)

plot(dat$V1/60, dat$V4, type="l", xlim=c(0,2*Time), ylim=c(-0.03, 0.26), xaxt="n")
lines(0:Time,rep(-0.02, Time+1), col=rgb(blue[1], blue[2], blue[3]), lwd=3)
lines(Time:(2*Time),rep(-0.02, Time+1), col=rgb(orange[1],orange[2],orange[3]), lwd=3)
axis(side=1, labels=F)
axis(side=2, labels=F)

plot(dat$V1/60, dat$V5, type="l", xlim=c(0,2*Time), ylim=c(-0.03, 0.26))
lines(0:Time,rep(-0.02, Time+1), col=rgb(blue[1], blue[2], blue[3]), lwd=3)
lines(Time:(2*Time),rep(-0.02, Time+1), col=rgb(orange[1],orange[2],orange[3]), lwd=3)
axis(side=2, labels=F)

mtext("h", side = 1, outer = TRUE, cex = 1, line = 2.2)
mtext("OD", side = 2, outer = TRUE, cex = 1, line = 2.2)
mtext(cepa, side = 3, outer = TRUE, cex = 1.7, line = 2.2)

