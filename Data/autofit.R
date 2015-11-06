#1. archivo
#2. horas
#3. intervalo
#4. diferencia


args <- commandArgs(T)

dat <- read.table(args[1]) 
hours <- as.numeric(args[2])
interval <- as.numeric(args[3])
diff <- as.numeric(args[4])

ch1 <- dat$V2
ch2 <- dat$V3
ch3 <- dat$V4
ch4 <- dat$V5

ch1M <- dat$V2
ch2M <- dat$V3
ch3M <- dat$V4
ch4M <- dat$V5


test <- ch3M[(((interval-1)*hours*12) + 1):(interval*hours*12)] 
a <- 0
b <- 0
i <- 1
lista <- 1
for (i in 1:(hours*12 - 1)){
	a <- test[i]
	b <- test[i+1]
	if  ((a-b) > diff) {lista <- c(lista, i)}
}
lista <- c(lista, hours*12)

allfits <- rep(0,length(lista)-1)
par(mfrow=c(length(allfits),1))
for (i in 1:(length(lista)-1)){
	ini <- lista[i]
	fin <- lista[i+1]
	ydata <- log2(test[ini:fin])
	xdata <- seq(0,length(ydata)*5, length.out=length(ydata))
	fit <- lm(ydata~xdata)
	allfits[i] <- 1/(summary(fit)$coefficients[2,1])
	plot(xdata, ydata)
	abline(fit)
}

print(allfits)
print(mean(allfits))
	


means <- c(means, mean(allfits))
std <- c(std, sd(allfits))

arrows(seq(1:12), glu$means-glu$std, seq(1:12), glu$means+glu$std, length=0.05, angle=90, code=3, col=3)
arrows(seq(1:12), glu$means-glu$std, seq(1:12), glu$means+glu$std, length=0.05, angle=90, code=3, col=2)
