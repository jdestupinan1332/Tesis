args <- commandArgs(T)

dat <- read.table(args[1])
print(args[1])

filen <- gsub(".txt", ".png", args[1])
png(filen, width=1080, height=500, units="px")
par(mfrow=c(1,2))
plot(dat$V1/60,dat$V2, type="l", main="C1", xlab="h", ylab="V")
plot(dat$V1/60,dat$V3, type="l", main="C2", xlab="h", ylab="V")
dev.off()