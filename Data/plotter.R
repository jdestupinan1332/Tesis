args <- commandArgs(T)

dat <- read.table(args[1])
print(args[1])

filen <- gsub(".txt", ".png", args[1])

png(paste("Ch1",filen), width=672*2, height=672, units="px")
plot(dat$V1/60, dat$V2, type="l", main="C1", xlab="h", ylab="OD")
dev.off()

png(paste("Ch2",filen), width=672*2, height=672, units="px")
plot(dat$V1/60, dat$V3, type="l", main="C2", xlab="h", ylab="OD")
dev.off()

png(paste("Ch3",filen), width=672*2, height=672, units="px")
plot(dat$V1/60, dat$V4, type="l", main="C3", xlab="h", ylab="OD")
dev.off()

png(paste("Ch4",filen), width=672*2, height=672, units="px")
plot(dat$V1/60, dat$V5, type="l", main="C4", xlab="h", ylab="OD")
dev.off()

