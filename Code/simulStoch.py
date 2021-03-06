#Simulacion trancisiones estocasticas
#A se vuelve B a una taza gamma, en medio oscilante
def growth3(A, B, gAl, gBl, gam, Media, Tl, tactual):
      	#Simulacion con algoritmo de gillespie
        ind = where(Tl==round(tactual,3))
        med = Media[ind]
        gA=0.0
        gB=0.0
        
	#Check en que medio estamos
        if med == 1:                         #Estamos en A
            gA = gAl[0]
            gB = gBl[0]
        else:                                #Estamos en B
            gA = gAl[1]
            gB = gBl[1]
        
	#Calcula saltos   
        K = 2*gam*A + 2*gam*B + A/gA + B/gB 
        u = random.random(3)
        talgo = 1/K * log(1/u[0])                                      
        if u[1] < (2*gam*A)/K:               #A pasa a B
            A = A-1
            B = B+1
        elif u[1] < (2*gam*A + 2*gam*B)/K:   #B pasa a A
            A = A+1
            B = B-1
        elif u[1] < (2*gam*A + 2*gam*B + A/gA)/K:#A crece
            A = A+1
            if u[2] < 0.5:                   #Moran
                if A!=0:
                    A=A-1
            else:
                if B!=0:
                    B=B-1
        else:                                #crece
            B = B+1
            if u[2] < 0.5:                   #Moran
                if A!=0:
                    A=A-1
            else:
                if B!=0:
                    B=B-1
        return A, B, talgo


#Definicion de listas y condiciones
B = array([500.0])   #Numero de celulas B
A = array([500.0])   #Numero de celulas A

gA = [130.0, 1300.0]
gB = [1400.0, 140.0]
gam = 1/(6*60.0)

tmax = 48*60.0       #tiempo de simulacion
T = array([0])

Tm = arange(0,tmax,0.001)      
Media = signal.square(pi/(24*60.0) *Tm)

plot(Tm/60.0,Media)
ylim(-2,2)
xlabel("h")
ylabel("Medio")

#Se resuelven las ecuaciones
t=0.0
i=0
while (t<tmax):
    An, Bn, dt = growth3(A[i], B[i], gA, gB, gam, Media, Tm, t)
    A = append(A,An)
    B = append(B,Bn)
    
    T = append(T,t+dt)
    i = i+1
    t = t+dt
  
    
#Grafica proporciones
plot(T/60.0,A/(A+B), label="A")
plot(T/60.0,B/(A+B), label="B")
xlabel("h")
ylabel("ratio")
legend()


#Competencia estocastica
def growth4(A, B, C, D, gAl, gBl, gCl, gDl, 
	    gamAB, gamCD, Media, Tl, tactual):
        #Simulacion con algoritmo de gillespie
        ind = where(Tl==round(tactual,3))
        med = Media[ind]
        gA=0.0
        gB=0.0
        #Check en que medio estamos
        if med == 1:                           #Estamos en A
            gA = gAl[0]
            gB = gBl[0]
            gC = gCl[0]
            gD = gDl[0]
        else:                                  #Estamos en B
            gA = gAl[1]
            gB = gBl[1]
            gC = gCl[1]
            gD = gDl[1]
	
	#Calcula saltos            
        K = 2*gamAB*A + 2*gamAB*B + 2*gamCD*C + 2*gamCD*D +
	    A/gA + B/gB + C/gC + D/gD
        u = random.random(2)
        talgo = 1/K * log(1/u[0])                                      
        if u[1] < (2*gamAB*A)/K:              #A pasa a B
            A = A-1
            B = B+1
            C = C
            D = D
        elif u[1] < (2*gamAB*A+2*gamAB*B)/K:  #B pasa a A
            A = A+1
            B = B-1
            C = C
            D = D
        elif u[1] < (2*gamAB*A+2*gamAB*B+2*gamCD*C)/K:#C pasa a D
            A = A
            B = B
            C = C-1
            D = D+1
        elif u[1] < (2*gamAB*A+2*gamAB*B+2*gamCD*C+
		     2*gamCD*D)/K:             #B pasa a A
            A = A
            B = B
            C = C+1
            D = D-1
        elif u[1] < (2*gamAB*A+2*gamAB*B+2*gamCD*C+
		     2*gamCD*D+A/gA)/K:       #A crece
            A = A+1
            A,B,C,D = checkmoran(A,B,C,D)
            if A+B+C+D!=10000:
                A = A-1
        elif u[1] < (2*gamAB*A+2*gamAB*B+2*gamCD*C+
		     2*gamCD*D+A/gA+B/gB)/K:  #B crece
            B = B+1
            A,B,C,D = checkmoran(A,B,C,D)
            if A+B+C+D!=10000:
                B = B-1
        elif u[1] < (2*gamAB*A+2*gamAB*B+2*gamCD*C+
		     2*gamCD*D+A/gA+B/gB+C/gC)/K:#C crece
            C = C+1
            A,B,C,D = checkmoran(A,B,C,D)
            if A+B+C+D!=10000:
                C = C-1
        else:                                  #D crece
            D = D+1
            A,B,C,D = checkmoran(A,B,C,D)
            if A+B+C+D!=10000:
                D = D-1
    
        return A, B, C, D, talgo

def checkmoran(A,B,C,D):
    u = random.random(1)
    if u < 0.25 and A>0:                                
        A=A-1
    elif u < 0.5 and B>0:
        B=B-1
    elif u < 0.75 and C>0:
        C=C-1
    elif u < 1.00 and D>0:
        D=D-1
           
    return A,B,C,D


#definicion de listas y condiciones iniciales
A = array([2500.0])             #Numero de celulas A
B = array([2500.0])             #Numero de celulas B

C = array([2500.0])             #Numero de celulas C
D = array([2500.0])             #Numero de celulas D

gA = [130.0, 1300.0]            #Crecimiento A
gB = [1400.0, 140.0]            #Crecimiento B 
gC = [130.0, 1300.0]            #Crecimiento C
gD = [1400.0, 140.0]            #Crecimiento D
gamAB = 1/(6*60.0)              #Transicion A-B
gamCD = 1/(24*60.0)             #Transicion C-D

tmax = 24*60.0                  #tiempo de simulacion
T = array([0])                  #Lista tiempo

Tm = arange(0,tmax,0.001)      
Media = signal.square(pi/(6*60.0) *Tm) #Variacion en medio
plot(Tm,Media)
ylim(-2,2)


#Se resuelven ecuaciones diferenciales
t=0.0
i=0
An = 2500
Bn = 2500
Cn = 2500
Dn = 2500
while (t<tmax and (An+Bn)!=0 and (Cn+Dn)!=0):
    An, Bn, Cn, Dn, dt = growth4(A[i], B[i], C[i], D[i],
 				 gA, gB, gC, gD, gamAB,
				 gamCD, Media, Tm, t)
    A = append(A,An)
    B = append(B,Bn)
    C = append(C,Cn)
    D = append(D,Dn)
    
    T = append(T,t+dt)
    i = i+1
    t = t+dt

#grafica de subpoblaciones individuales
plot(T, A, label="A")
plot(T, B, label="B")
plot(T, C, label="C")
plot(T, D, label="D")

#grafica proporciones
plot(T,(A+B)/(A+B+C+D), label="A+B")
plot(T,(C+D)/(A+B+C+D), label="C+D")
legend()

