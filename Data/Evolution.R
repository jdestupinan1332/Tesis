blueth <- rgb(66/255, 133/255, 244/255)
orangeth <- rgb(255/255, 87/255, 34/255) 

datos <- data.frame(Azucar = c(rep(c("Glucosa", "Galactosa"), 4), "Glucosa"), means, std)
glu <- subset(datos, Azucar=="Glucosa")
gal <- subset(datos, Azucar=="Galactosa")

par(mfrow=c(1,1))
plot(glu$means, xlab = "ciclo", ylab = "tiempo de duplicación (min)", ylim = c(90, 210), col=blueth)
points(gal$means, col=orangeth)
abline(lm(glu$means ~ c(1:5)), col=blueth)
abline(lm(gal$means ~ c(1:4)), col=orangeth)
arrows(seq(1:5), glu$means-glu$std, seq(1:5), glu$means+glu$std, length=0.05, angle=90, code=3, col=blueth)
arrows(seq(1:4), gal$means-gal$std, seq(1:4), gal$means+gal$std, length=0.05, angle=90, code=3, col=orangeth)
legend("topleft", c("Glucosa", "Galactosa"), lty=c(1,1), lwd=c(2.5,2.5),col=c(blueth, orangeth))


barplot(means, names=c("Glucosa", "Galactosa"), col=c(blueth, orangeth), ylab="tiempo de duplicación (min)", main="")
arrows(0.7, means[1], 0.7, means[1]+stds[1], angle=90)
arrows(1.92, means[2], 1.92, means[2]+stds[2], angle=90)

boxplot(datos$means ~ datos$Azucar, col=c(orangeth, blueth), main="")

