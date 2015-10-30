from scipy import signal
def growth2(A, B, media, gA, gB, gam):  
    if media == 1:            
        vA = gam*(B-A) + A/gA[0]
        vB = -gam*(B-A) + B/gB[0]
    if media == -1:            
        vA = gam*(B-A) + A/gA[1]
        vB = -gam*(B-A) + B/gB[1]   
    return vA,vB

def RK2(listA, listB, listvA, listvB, media, gA, gB, dt, tmax, gam):
    n=0
    while n < (tmax/dt-1):
        At = listA[n]
        Bt = listB[n]
        vAt = listvA[n]
        vBt = listvB[n]
        m = media[n]
        
        K1 = vAt*dt
        L1 = vBt*dt
        
        At = listA[n] + 0.5*K1
        Bt = listB[n] + 0.5*L1
        vAt, vBt = growth2(At, Bt, m, gA, gB, gam)
        
        K2 = vAt*dt
        L2 = vBt*dt
        
        At = listA[n] + 0.5*K2
        Bt = listB[n] + 0.5*L2
        vAt, vBt = growth2(At, Bt, m, gA, gB, gam)
        
        K3 = vAt*dt
        L3 = vBt*dt
        
        At = listA[n] + 0.5*K3
        Bt = listB[n] + 0.5*L3
        vAt, vBt = growth2(At, Bt, m, gA, gB, gam)
        
        K4 = vAt*dt
        L4 = vBt*dt
        
        K = (K4 + 2*K3 + 2*K2 + K1)/6.0
        L = (L4 + 2*L3 + 2*L2 + L1)/6.0
        
        listA[n+1] = listA[n] + K
        listB[n+1] = listB[n] + L
        listvA[n+1], listvB[n+1]= growth2(listA[n+1], 
					  listB[n+1], m, gA, gB, gam)
        
        n = n+1

#Definicion listas
tmax = 7*24*60.0                  
dt=1/(60.0*2)                    
A = zeros(tmax/dt)         
vA = zeros(tmax/dt) 
B = zeros(tmax/dt)
vB = zeros(tmax/dt)

C = zeros(tmax/dt)         
vC = zeros(tmax/dt) 
D = zeros(tmax/dt)
vD = zeros(tmax/dt)

T = arange(0,tmax,dt)      
Media = signal.square(pi/(6*60.0) *T)  #Oscilaciones medio

#Definicion Condiciones iniciales
A[0] = 50
B[0] = 0
gA = [130.0, 1300.0]
gB = [1400.0, 140.0]
gammA = 1/(6*60.0)                 
vA[0], vB[0] = growth2(A[0], B[0], Media[0], gA, gB, gammA)

C[0] = 50
D[0] = 0
gC = [130.0, 1300.0]
gD = [1400.0, 140.0]
gammB = 1/(24*60.0)                 
vC[0], vD[0] = growth2(C[0], D[0], Media[0], gC, gD, gammB)


#Se resuelven las ecuaciones diferenciales
RK2(A, B, vA, vB, Media, gA, gB, dt, tmax, gammA)
RK2(C, D, vC, vD, Media, gC, gD, dt, tmax, gammB)


#Grafica
figsize(14,7)
plot(T/60.0,(A+B)/(A+B+C+D), label="Fast")
plot(T/60.0,(C+D)/(A+B+C+D), label="Slow")
xlabel("h")
ylabel("fraccion")
title("Competencia 6h")
legend()







