data <- read.table("5.14.Conteo.txt", h=T)
c1 <- subset(data, Carril=="C1")
c2 <- subset(data, Carril=="C2")
c1 <- aggregate(c1[,3:4], list(c1$Tiempo), mean)
c2 <- aggregate(c2[,3:4], list(c2$Tiempo), mean)

png("fitt**2", width=1080, height=500, units="px")
par(mfrow=c(1,2))
print("C1.1")
xdata <- c1$Group.1
ydata <- c1$Conteo
fit <- nls(ydata ~ p1 + p2*(xdata^2), start=list(p1=0.001, p2=0.001))
print(summary (fit))
plot(xdata,ydata, xlab="T", ylab="Cont")
new = data.frame(xdata = seq(min(xdata),max(xdata),len=200))
lines(new$xdata,predict(fit,newdata=new))
print("C2.1")
xdata <- c2$Group.1
ydata <- c2$Conteo
fit <- nls(ydata ~ p1 + p2*(xdata^2), start=list(p1=0.001, p2=0.001))
print(summary (fit))
plot(xdata,ydata, xlab="T", ylab="Cont")
new = data.frame(xdata = seq(min(xdata),max(xdata),len=200))
lines(new$xdata,predict(fit,newdata=new))
dev.off()


png("fit2**t", width=1080, height=500, units="px")
par(mfrow=c(1,2))
print("C1.2")
xdata <- c1$Group.1
ydata <- c1$Conteo
fit <- nls(ydata ~ p1 + 2^(p2*xdata), start=list(p1=0.001, p2=0.001))
print(summary (fit))
plot(xdata,ydata, xlab="T", ylab="Cont")
new = data.frame(xdata = seq(min(xdata),max(xdata),len=200))
lines(new$xdata,predict(fit,newdata=new))
print("C2.2")
xdata <- c2$Group.1
ydata <- c2$Conteo
fit <- nls(ydata ~ p1 + 2^(p2*xdata), start=list(p1=0.001, p2=0.001))
print(summary (fit))
plot(xdata,ydata, xlab="T", ylab="Cont")
new = data.frame(xdata = seq(min(xdata),max(xdata),len=200))
lines(new$xdata,predict(fit,newdata=new))
dev.off()


png("fite**t", width=1080, height=500, units="px")
par(mfrow=c(1,2))
print("C1.3")
xdata <- c1$Group.1
ydata <- c1$Conteo
fit <- nls(ydata ~ p1 + exp(p2*xdata), start=list(p1=0.001, p2=0.001))
print(summary (fit))
plot(xdata,ydata, xlab="T", ylab="Cont")
new = data.frame(xdata = seq(min(xdata),max(xdata),len=200))
lines(new$xdata,predict(fit,newdata=new))
print("C2.3")
xdata <- c2$Group.1
ydata <- c2$Conteo
fit <- nls(ydata ~ p1 + exp(p2*xdata), start=list(p1=0.001, p2=0.001))
print(summary (fit))
plot(xdata,ydata, xlab="T", ylab="Cont")
new = data.frame(xdata = seq(min(xdata),max(xdata),len=200))
lines(new$xdata,predict(fit,newdata=new))
dev.off()
