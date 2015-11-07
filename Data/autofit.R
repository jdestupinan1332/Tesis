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

ch1M <- numeric(0)
ch2M <- numeric(0)
ch3M <- numeric(0)
ch4M <- numeric(0)
means <- numeric(0)
std <- numeric(0)

#Datos cada 5 mins
for(j in 1:length(dat$V1)){
  if (j%%5 == 0){
  ch1M <- c(ch1M, dat$V2[j])
  ch2M <- c(ch2M, dat$V3[j])
  ch3M <- c(ch3M, dat$V4[j])
  ch4M <- c(ch4M, dat$V5[j])
  }
}

test <- ch4M[(((interval-1)*hours*12) + 1):(interval*hours*12)] 
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
par(mfrow=c(4,3))
for (i in 1:(length(lista)-1)){
	ini <- lista[i]
	fin <- lista[i+1]
	ydata <- log2(test[(ini+1):fin])
	xdata <- seq(0,length(ydata)*5, length.out=length(ydata))
	fit <- lm(ydata~xdata)
	allfits[i] <- 1/(summary(fit)$coefficients[2,1])
	plot(xdata, ydata)
  abline(fit)
}

print(allfits)
print(mean(allfits))
	
means <- c(means, mean(allfits[2:9]))
std <- c(std, sd(allfits[2:9]))


#Corrección para los que sean negativos
i <- 2
ini <- lista[i]
fin <- lista[i+1]
ydata <- log2(test[(ini+2):fin])
xdata <- seq(0,length(ydata)*5, length.out=length(ydata))
plot(xdata, ydata)
fit <- lm(ydata~xdata)
abline(fit)
1/(summary(fit)$coefficients[2,1])
