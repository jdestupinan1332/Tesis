args <- commandArgs(T)# Calib.txt y Conteo.txt

dat <- read.table(args[1]) #datos de calibracion
dat2 <- read.table(args[2], h=T) #datos de plaqueo

c1 <- subset(dat2, Carril=="C1") 
c2 <- subset(dat2, Carril=="C2")
c1 <- aggregate(c1[,3:4], list(c1$Tiempo), mean)
c2 <- aggregate(c2[,3:4], list(c2$Tiempo), mean)


filen <- gsub("Conteo.txt", "Fit.png", args[2]) #cambia nombre

png(filen, width=672*2, height=672, units="px")
par(mfrow=c(1,2))

###Carril 1####
	par(mar = c(5, 4, 4, 4) + 0.3) 
	plot(c1$Group.1/60, c1$Conteo, ylab="Colonias", xlab="Tiempo (h)", main="C1",
		xlim=c(0,4.5)) #Cambiar rango de tiempo
	#Fit
	xdata <- c1$Group.1
	ydata <- c1$Conteo
	fit <- nls(ydata ~ p1 * 2^(1/p2*xdata), start=list(p1=10.0, p2=75.0))
	new = data.frame(xdata = seq(min(xdata),max(xdata),len=200))
	lines(new$xdata/60,predict(fit,newdata=new))
	#Calib
	par(new=T)
	plot(dat$V1/60,dat$V2, axes=F, type="l", xlab="", ylab="", col="gray77", 
		xlim=c(0,4.5)) #Cambiar rango de tiempo
	axis(side=4, at=pretty(range(dat$V2))) #Rango de Voltaje
	mtext("V", side=4, line=3)

###Carril 2####
	par(mar = c(5, 4, 4, 4) + 0.3) 
	plot(c2$Group.1/60, c2$Conteo, ylab="Colonias", xlab="Tiempo (h)", main="C2",
		xlim=c(0,4.5)) #Cambiar rango de tiempo
	#Fit
	xdata <- c2$Group.1
	ydata <- c2$Conteo
	fit <- nls(ydata ~ p1 * 2^(1/p2*xdata), start=list(p1=1.0, p2=75.0))
	new = data.frame(xdata = seq(min(xdata),max(xdata),len=200))
	lines(new$xdata/60,predict(fit,newdata=new))
	#Calib
	par(new=T)
	plot(dat$V1/60,dat$V3, axes=F, type="l", xlab="", ylab="", col="gray77", 
		xlim=c(0,4.5)) #Cambiar rango de tiempo
	axis(side=4, at=pretty(range(dat$V3))) #Rango de Voltaje
	mtext("V", side=4, line=3)

dev.off()




