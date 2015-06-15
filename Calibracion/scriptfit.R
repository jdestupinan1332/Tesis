args <- commandArgs(T) #Conteo.txt

data <- read.table(args[1], h=T) #datos de plaqueo
c1 <- subset(data, Carril=="C1")
c2 <- subset(data, Carril=="C2")
c1 <- aggregate(c1[,3:4], list(c1$Tiempo), mean)
c2 <- aggregate(c2[,3:4], list(c2$Tiempo), mean)

print("C1")
xdata <- c1$Group.1
ydata <- c1$Conteo
fit <- nls(ydata ~ p1 * 2^(1/p2*xdata), start=list(p1=10.0, p2=75.0))
print(summary (fit))

print("C2")
xdata <- c2$Group.1
ydata <- c2$Conteo
fit <- nls(ydata ~ p1 * 2^(1/p2*xdata), start=list(p1=10.0, p2=75.0))
print(summary (fit))

print("C1")
xdata <- c1$Group.1
ydata <- c1$Conteo
fit <- nls(ydata ~ p1 * exp(1/p2*xdata), start=list(p1=10.0, p2=75.0))
print(summary (fit))

print("C2")
xdata <- c2$Group.1
ydata <- c2$Conteo
fit <- nls(ydata ~ p1 * exp(1/p2*xdata), start=list(p1=10.0, p2=75.0))
print(summary (fit))

