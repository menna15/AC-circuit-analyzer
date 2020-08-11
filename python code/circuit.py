import ahkab
import numpy as np
import time
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
