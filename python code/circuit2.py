import ahkab
import numpy as np
LANG="en_US.UTF-8"
Circuit = ahkab.Circuit("AC Circuit")
def phase(x,y):
    return np.complex(x*np.math.cos(y*np.math.pi/180),x*np.math.sin(y*np.math.pi/180))
File = open('YC.txt')
for line in File:
    L = line.split()
    if len(L)>0:
        if L [0][0]=='R':
            Circuit.add_resistor(L[0],L[1],L[2],float (L[3]))
        elif L [0][0]=='L':
            Circuit.add_inductor(L[0],L[1],L[2],float (L[3]))
        elif L [0][0]=='C':
            Circuit.add_capacitor(L[0],L[1],L[2],float (L[3]))
        elif L [0][0]=='V':
            Circuit.add_vsource(L[0],L[1],L[2],dc_value=0,ac_value=phase(float(L[3]),float(L[4])))
        elif L [0][0]=='I':
            Circuit.add_isource(L[0],L[1],L[2],dc_value=0,ac_value=phase(float(L[3]),float(L[4])))
        elif L [0][0]=='W':
            frequency = float (L[1])/(2*np.math.pi)
        elif L[0][0]=='G':
             Circuit.add_vccs (L[0],L[1],L[2],L[3],L[4],float(L[5]))
        elif L [0][0]=='H':
            Circuit.add_ccvs (L [0],L[1],L[2],L[3],float(L[4]))
        elif L [0][0]=='F':
            Circuit.add_cccs (L [0],L[1],L[2],L[3],float(L[4]))
        elif L[0][0]=='E':
             Circuit.add_vcvs (L[0],L[1],L[2],L[3],L[4],float(L[5]))
        else: print ("Invalid Input")   
File.close()
ac=ahkab.new_ac(start = frequency,stop = frequency,points= 2,x0=None)
res = ahkab.run(Circuit,ac)
pp=res['ac'].keys()
ppp=res['ac']['V1'][0]
ppp2=res['ac']['V2'][0]
f= open("results.txt","w")
File = open('YC.txt')
for k in File:
    L=k.split(' ')
    if L[0]=='W':
        omega=float(L[1])
    if L[0][0]=='V':
        print ('power in vsource :'+ L[0])
        power = 0.5*(phase(float(L[3]),float(L[4])))*np.conj(res['ac']['I('+ L[0]+')'][0])
        print(power)
        f.write("power in vsource :"+ L[0]+"=") 
        f.write(str(power))
        f.write("\n")
        f.write("\n")
    if L[0][0]=='I':
         if L[1] == '0':
            power = 0.5*(0-(res['ac']['V'+L[2]][0]))*np.conj(phase(float(L[3]),float(L[4])))
         elif L[2] == '0':
            power = 0.5*((res['ac']['V'+L[1]][0])*np.conj(phase(float(L[3]),float(L[4]))))
         else:
            power = 0.5*((res['ac']['V'+L[1]][0])-(res['ac']['V'+L[2]][0]))*np.conj(phase(float(L[3]),float(L[4])))
         print ('power in Isource :'+ L[0])
         print(power)
         f.write('power in Isource :'+ L[0]+"=") 
         f.write(str(power))
         f.write("\n")
         f.write('Voltage at the nodes of the current source')
         f.write("\n")
         if L[1] !='0':
          f.write('V'+ L[1]+"=") 
          f.write(str(res['ac']['V'+L[1]][0]))
          f.write("\n")
          f.write("\n")
         else:
          f.write('V'+ L[1]+"= 0")
          f.write("\n")
          f.write("\n")
         if L[2] !='0':
          f.write('V'+ L[2]+"=") 
          f.write(str(res['ac']['V'+L[2]][0]))
          f.write("\n")
          f.write("\n")
         else:
          f.write('V'+ L[1]+"= 0")
          f.write("\n")
          f.write("\n")
    if L[0][0]=="R":
        if L[1] == '0':
          I = (res['ac']['V'+L[2]][0])/float(L[3])
        elif L[2] =='0':
          I = (res['ac']['V'+L[1]][0])/float(L[3])
        else:
          I = ((res['ac']['V'+L[2]][0])-(res['ac']['V'+L[1]][0]))/float(L[3])
        power = 0.5*(pow(I.imag , 2)+ pow(I.real ,2))*float(L[3])
        print ('power in resistant :'+ L[0])
        print(power)
        f.write('power in resistant :'+ L[0]+"=") 
        f.write(str(power))
        f.write("\n")
        f.write('Voltage at the nodes of the Resistor')
        f.write("\n")
        if L[1] !='0':
         f.write('V'+ L[1]+"=") 
         f.write(str(res['ac']['V'+L[1]][0]))
         f.write("\n")
         f.write("\n")
        else:
         f.write('V'+ L[1]+"= 0")
         f.write("\n")
         f.write("\n")
        if L[2] !='0':
         f.write('V'+ L[2]+"=") 
         f.write(str(res['ac']['V'+L[2]][0]))
         f.write("\n")
         f.write("\n")
        else:
         f.write('V'+ L[2]+"= 0")
         f.write("\n")
         f.write("\n")
    if L[0][0]=="L":
        if L[1] == '0':
          I = (0-res['ac']['V'+L[2]][0])/complex(0,float(L[3])*omega)
          power = 0.5*(0-res['ac']['V'+L[2]][0])*np.conj(I)
        elif L[2] =='0':
          I = (res['ac']['V'+L[1]][0])/complex(0,float(L[3])*omega)
          power = 0.5*(res['ac']['V'+L[1]][0])*np.conj(I)
        else:
          I = ((res['ac']['V'+L[1]][0])-(res['ac']['V'+L[2]][0]))/complex(0,float(L[3])*omega)
          power = 0.5*((res['ac']['V'+L[1]][0])-(res['ac']['V'+L[2]][0]))*np.conj(I)
        print ('power in inductor :'+ L[0])
        print(power)
        f.write('power in inductor :'+ L[0]+"=") 
        f.write(str(power))
        f.write("\n")
        f.write('Voltage at the nodes of the inductor')
        f.write("\n")
        if L[1] !='0':
         f.write('V'+ L[1]+"=") 
         f.write(str(res['ac']['V'+L[1]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[1]+"= 0") 
          f.write("\n")
          f.write("\n")
        if L[2] !='0':
         f.write('V'+ L[2]+"=") 
         f.write(str(res['ac']['V'+L[2]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[2]+"= 0")
          f.write("\n")
          f.write("\n")
    
    if L[0][0]=="C":
        if L[1] == '0':
          I = (0-res['ac']['V'+L[2]][0])/(1/(complex(0,(float(L[3])*omega))))
          power = 0.5*(0-res['ac']['V'+L[2]][0])*np.conj(I)
        elif L[2] =='0':
          I = (res['ac']['V'+L[1]][0])/(1/(complex(0,(float(L[3])*omega))))
          power = 0.5*(res['ac']['V'+L[1]][0])*np.conj(I)
        else:
          I = ((res['ac']['V'+L[1]][0])-(res['ac']['V'+L[2]][0]))/(1/(complex(0,(float(L[3])*omega))))
          power = 0.5*((res['ac']['V'+L[1]][0])-(res['ac']['V'+L[2]][0]))*np.conj(I)
        print ('power in capcitor :'+ L[0])
        print(power) 
        f.write('power in capcitor :'+ L[0]+"=") 
        f.write(str(power))
        f.write("\n")
        f.write('Voltage at the nodes of the capacitor')
        f.write("\n")
        if L[1] !='0':
         f.write('V'+ L[1]+"=") 
         f.write(str(res['ac']['V'+L[1]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[1]+"= 0") 
          f.write("\n")
          f.write("\n")
        if L[2] !='0':
         f.write('V'+ L[2]+"=") 
         f.write(str(res['ac']['V'+L[2]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[2]+"= 0")
          f.write("\n")
          f.write("\n")
    if L[0][0]=="F": #cccs
        if L[1] == '0':
          power = 0.5*(res['ac']['V'+L[2]][0])*np.conj(float(L[4])*(res['ac']['I(VF'+L[0][1]+')'][0]))
        elif L[2] =='0':
          power = 0.5*(0-res['ac']['V'+L[1]][0])*np.conj(float(L[4])*(res['ac']['I(VF'+L[0][1]+')'][0]))
        else:
          power = 0.5*((res['ac']['V'+L[2]][0])-(res['ac']['V'+L[1]][0]))*np.conj(float(L[4])*(res['ac']['I(VF'+L[0][1]+')'][0]))
        print ('power in cccs(F) :'+ L[0])
        print(power)
        f.write('power in cccs(F) :'+ L[0]+"=") 
        f.write(str(power))
        f.write("\n")
        f.write('Voltage at the nodes of the cccs')
        if L[1] !='0':
         f.write('V'+ L[1]+"=") 
         f.write(str(res['ac']['V'+L[1]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[1]+"= 0")
          f.write("\n")
          f.write("\n")
        if L[2] !='0':
         f.write('V'+ L[2]+"=") 
         f.write(str(res['ac']['V'+L[2]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[2]+"= 0") 
          f.write("\n")
          f.write("\n")
    if L[0][0]=="H": #ccvs
        power = 0.5*(float(L[4])*(res['ac']['I(VH'+L[0][1]+')'][0]))*np.conj(res['ac']['I(H'+L[0][1]+')'][0])
        print ('power in ccvs(H) :'+ L[0])
        print(power)
        f.write('power in ccvs(H) :'+ L[0]+"=") 
        f.write(str(power))
        f.write("\n")
        f.write('Voltage at the nodes of the ccvs')
        if L[1] !='0':
         f.write('V'+ L[1]+"=") 
         f.write(str(res['ac']['V'+L[1]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[1]+"= 0") 
          f.write("\n")
          f.write("\n")
        if L[2] !='0':
         f.write('V'+ L[2]+"=") 
         f.write(str(res['ac']['V'+L[2]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[2]+"= 0")
          f.write("\n")
          f.write("\n")
    if L[0][0]=="G": #vccs
        if L[3] == '0':
            if L[1] == '0':
                power =0.5*(0-res['ac']['V'+L[2]][0])*(np.conj(float(L[5])*(0-res['ac']['V'+L[4]][0])))
            elif L[2] =='0':
                power =0.5*(res['ac']['V'+L[1]][0])*(np.conj(float(L[5])*(0-res['ac']['V'+L[4]][0])))
            else:
                power =0.5*((res['ac']['V'+L[1]][0])-(res['ac']['V'+L[2]][0]))*(np.conj(float(L[5])*(0-res['ac']['V'+L[4]][0])))
        elif L[4] == '0':
            if L[1] == '0':
                power =0.5*(0-res['ac']['V'+L[2]][0])*(np.conj(float(L[5])*(res['ac']['V'+L[3]][0])))
            elif L[2] =='0':
                power =0.5*((res['ac']['V'+L[1]][0]))*(np.conj(float(L[5])*(res['ac']['V'+L[3]][0])))
            else:
                power =0.5*((res['ac']['V'+L[1]][0])-(res['ac']['V'+L[2]][0]))*(np.conj(float(L[5])*(res['ac']['V'+L[3]][0])))
        else:
            if L[1] == '0':
                power =0.5*(0-res['ac']['V'+L[2]][0])*(np.conj(float(L[5])*(res['ac']['V'+L[3]][0]))-res['ac']['V'+L[4]][0])
            elif L[2] =='0':
                power =0.5*((res['ac']['V'+L[1]][0]))*(np.conj(float(L[5])*(res['ac']['V'+L[3]][0]))-res['ac']['V'+L[4]][0])
            else:
                power =0.5*((res['ac']['V'+L[1]][0])-(res['ac']['V'+L[2]][0]))*(np.conj(float(L[5])*(res['ac']['V'+L[3]][0]))-res['ac']['V'+L[4]][0])
        print ('power in vccs(G) :'+ L[0])
        print(power)
        f.write('power in vccs(G) :'+ L[0]+"=") 
        f.write(str(power))
        f.write("\n")
        f.write('Voltage at the nodes of the vccs')
        f.write("\n")
        if L[1] !='0':
         f.write('V'+ L[1]+"=") 
         f.write(str(res['ac']['V'+L[1]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[1]+"= 0")  
          f.write("\n")
          f.write("\n")
        if L[2] !='0':
         f.write('V'+ L[2]+"=") 
         f.write(str(res['ac']['V'+L[2]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[2]+"= 0")
          f.write("\n")
          f.write("\n")
    if L[0][0]=="E": #vcvs    
        if L[3] == '0':
            power =0.5*(float(L[5])*(0-res['ac']['V'+L[4]][0]))*(np.conj(res['ac']['I('+L[0]+')'][0]))
        elif L[4] == '0':
            power =0.5*(float(L[5])*(res['ac']['V'+L[3]][0]))*(np.conj(res['ac']['I('+L[0]+')'][0]))
        else:
            power =0.5*(float(L[5])*((res['ac']['V'+L[3]][0])-res['ac']['V'+L[4]][0]))*(np.conj(res['ac']['I('+L[0]+')'][0]))
        print ('power in vcvs(E) :'+ L[0])
        print(power)
        f.write('power in vcvs(E) :'+ L[0]+"=") 
        f.write(str(power))
        f.write("\n")
        f.write('Voltage at the nodes of the vcvs')
        f.write("\n")
        if L[1] !='0':
         f.write('V'+ L[1]+"=") 
         f.write(str(res['ac']['V'+L[1]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[1]+"= 0")
          f.write("\n")
          f.write("\n")
        if L[2] !='0':
         f.write('V'+ L[2]+"=") 
         f.write(str(res['ac']['V'+L[2]][0]))
         f.write("\n")
         f.write("\n")
        else:
          f.write('V'+ L[2]+"= 0") 
          f.write("\n")
          f.write("\n")
f.write("**********************************************************************************")
f.write("\n")
File.close()
f.close()
f= open("results.txt","r")
