args <- commandArgs(T) #CalibM.txt

dat <- read.table(args[1])
print("C1")
xdata <- dat$V1
ydata <- dat$V2
fit <- nls(ydata ~ p1 * exp(1/p2*xdata), start=list(p1=0.100, p2=75.0))
print(summary(fit))


filen <- gsub("CalibM.txt", "FitM.png", args[1])
png(filen, width=672*2, height=672, units="px")
par(mfrow=c(1,2))

plot(xdata, ydata, ylab="V", xlab="tiempo(min)", main="C1", type="l")
new = data.frame(xdata = seq(min(xdata),max(xdata),len=200))
lines(new$xdata,predict(fit,newdata=new), col=2)

print("C2")
xdata <- dat$V1
ydata <- dat$V3
fit <- nls(ydata ~ p1 * exp(1/p2*xdata), start=list(p1=0.100, p2=75.0))
print(summary(fit))

plot(xdata, ydata, ylab="V", xlab="tiempo(min)", main="C2", type="l")
new = data.frame(xdata = seq(min(xdata),max(xdata),len=200))
lines(new$xdata,predict(fit,newdata=new), col=2)

dev.off()

