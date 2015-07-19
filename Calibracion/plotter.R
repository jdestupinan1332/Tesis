args <- commandArgs(T)

dat <- read.table(args[1])
print(args[1])

filen <- gsub(".txt", ".png", args[1])
png(filen, width=672, height=672, units="px")
par(mfrow=c(1,1))
plot(dat$V1/60,dat$V2, type="l", main="C1", xlab="h", ylab="V")

dev.off()
