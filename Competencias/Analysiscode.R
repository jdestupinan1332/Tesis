dat <- read.table(args[1]) 
hours <- as.numeric(args[2])
diff <- as.numeric(args[4])

blueth <- rgb(66/255, 133/255, 244/255)
orangeth <- rgb(255/255, 87/255, 34/255) 

#Abre el archivo de datos
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

#Modifica para tomas datos cada 5 mins
for(j in 1:length(dat$V1)){
  if (j%%5 == 0){
    ch1M <- c(ch1M, dat$V2[j])
    ch2M <- c(ch2M, dat$V3[j])
    ch3M <- c(ch3M, dat$V4[j])
    ch4M <- c(ch4M, dat$V5[j])
  }
}

#DouTimes para toda la corrida
test <- ch4M[1:(2*hours*12)] 
a <- 0
b <- 0
i <- 1
lista <- 1
for (i in 1:(2*hours*12 - 1)){
  a <- test[i]
  b <- test[i+1]
  if  ((a-b) > diff) {lista <- c(lista, i)}
}
lista <- c(lista, 2*hours*12)

allfits <- rep(0,length(lista)-1)
par(mfrow=c(4,5))
for (i in 1:(length(lista)-1)){
  ini <- lista[i]
  fin <- lista[i+1]
  ydata <- log2(test[(ini+1):fin])
  xdata <- seq(0,length(ydata)*5, length.out=length(ydata))
  fit <- lm(ydata~xdata)
  allfits[i] <- 1/(summary(fit)$coefficients[2,1])
  plot(xdata, ydata, main=i)
  abline(fit, col=2)
}

remove <- numeric(0)
for (i in 1:length(allfits)){
  if(allfits[i] == 0){
    remove <- c(remove, i)
  }
}
lista <-lista[-(remove+1)]
allfits <- allfits[-remove]


#Corrección para los que sean negativos
i <- 1
ini <- lista[i]
fin <- lista[i+1]
ydata <- log2(test[(ini+1):(fin-1)])
xdata <- seq(0,length(ydata)*5, length.out=length(ydata))
plot(xdata, ydata, main=i)
fit <- lm(ydata~xdata)
abline(fit, col=2)
1/(summary(fit)$coefficients[2,1])

allfits[i] <- 1/(summary(fit)$coefficients[2,1])


#plot de evolución temporal del DouTime
par(mfrow=c(1,1))
plot(lista[2:length(lista)]*5/60, allfits, type="b", xlim=c(0,2*hours), ylim=c(70,210), ylab="Tiempo de duplicación (min)", xlab="Tiempo de dilución (h)", main="6hCh4 en T=24")
lines(0:hours,rep(81, hours+1), col=blueth, lwd=3)
lines(hours:(2*hours),rep(81, hours+1), col=orangeth, lwd=3)

#saca promedios de cada intervalo
index <- which(lista < hours*60/5)
means<-c(means, mean(allfits[1:(max(index)-1)]))
means<-c(means, mean(allfits[max(index):length(allfits)]))
std<-c(std, sd(allfits[1:(max(index)-1)]))
std<-c(std, sd(allfits[max(index):length(allfits)]))

#barplots de canal individual
k <- 1
par(mfrow=c(1,1))
barplot(means[k:(k+1)], names=c("Glucosa", "Galactosa"), col=c(blueth, orangeth), ylab="tiempo de duplicación (min)", main="6hCh4 en T=24", ylim=c(0,180))
arrows(0.7, means[k]-std[k], 0.7, means[k]+std[k], angle=90, length=0.05, code=3)
arrows(1.92, means[k+1]-std[k+1], 1.92, means[k+1]+std[k+1], angle=90, length=0.05, code=3)

#agrupa todos los promedios y plot
datos <- data.frame(Azucar = c("Glucosa", "Galactosa"), means, std)
boxplot(datos$means ~ datos$Azucar, col=c(orangeth, blueth), main="6h en T=24h")

write.table(datos,file="", row.names=F)


