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

test <- ch3[(((interval-1)*hours*60) + 1):(interval*hours*60)] 
a <- 0
b <- 0
i <- 1
lista <- 1
for (i in 1:(hours*60 - 1)){
	a <- test[i]
	b <- test[i+1]
	if  ((a-b) > diff) {lista <- c(lista, i)}
}

allfits <- rep(0,length(lista)-1)

for (i in 1:(length(lista)-1)){
	ini <- lista[i]
	fin <- lista[i+1]
	ydata <- log2(test[ini:fin])
	xdata <- seq(0,length(ydata), length.out=length(ydata))
	fit <- lm(ydata~xdata)
	allfits[i] <- 1/(summary(fit)$coefficients[2,1])
}

print(lista/60)
print(allfits)
print(mean(allfits))
	
