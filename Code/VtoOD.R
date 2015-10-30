args <- commandArgs(T)
dat <- read.table(args[1])
dat$V2 <- (dat$V2 - 0.12707)/1.92356
dat$V3 <- (dat$V3 - 0.42078)/3.22960
dat$V4 <- (dat$V4 - 0.28300)/4.71284
dat$V5 <- (dat$V5 - 0.21029)/3.88515

write.table(dat, file=args[1], row.names = F, col.names = F)

