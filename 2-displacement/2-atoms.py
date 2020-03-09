from __future__ import print_function
import numpy as np
from numpy import *
import math



numberline1 = 1
f1 =  open('supercell-001.data')
for line in f1:
  numberline1  = numberline1 +1
  if line.startswith("Atoms"):
     break

numberline = 1
f4 =  open("supercell-order.data")
for line in f4:
  numberline  = numberline +1
  if line.startswith("Atoms"):
     break





with open("supercell-order.data") as f3:
    for line in f3:
        line  = line.rstrip('\n')
        if "atoms" in line:
             atoms = line.split(" ")
        if "bonds" in line:
             bonds = line.split(" ")
        if "angles" in line:
             angles = line.split(" ")
atomnumber= int(atoms[0])
numberangles= int(angles[0])
numberbonds= int(bonds[0])

iDm = np.zeros(atomnumber)
iD = np.zeros(atomnumber)
#####################################################################################
oxygen=2
hydrogen=1

data1 = np.genfromtxt("supercell-001.data", skip_header=numberline1, max_rows=atomnumber)
data = np.genfromtxt("supercell-order.data", skip_header=numberline, max_rows=atomnumber)
a,mol,typ,charge,x,y,z,b = data[:,0],data[:,1],data[:,2],data[:,3],data[:,4],data[:,5],data[:,6],data[:,7]
typ1,x1,y1,z1 = data1[:,1], data1[:,2], data1[:,3], data1[:,4]

####################################print###############################################
charge[1]=-0.850
charge[2]=0.425
for i in range(0,atomnumber):
   iDm[int(a[i]-1)]=int(b[i])
   iD[int(b[i])]=int(a[i])-1

f = open("supercell-order-001.data", "w")



with open("supercell-order.data") as f3:
    for line in f3:
        line  = line.rstrip('\n')
        if "atoms" in line:
             print ("\n",line , file=f)
        if "atom types" in line:
             print (line, file=f)
        if "bonds" in line:
             print (line, file=f)
        if "angles" in line:
             print (line, file=f)
        if "bond types" in line:
             print (line, file=f),
        if "angle types" in line:
             print (line,"\n", file=f)
        if "xlo" in line:
             print (line, file=f)
        if "ylo" in line:
             print (line, file=f)
        if "zlo" in line:
             print (line, file=f)
        if "xy" in line:
             print (line,"\n", file=f)
#####################Massses########################
print ("\n", file=f)
numberlinemasses=0
always_print = False
with open("supercell-order.data") as f3:
    for line in f3:
        line  = line.rstrip('\n')
        if always_print or line.startswith("Masses"):
            numberlinemasses  = numberlinemasses +1
            print (line, file=f)
            always_print = True
            if numberlinemasses > 3:
                always_print = False
cc=1
#########################################################################
print( '\nAtoms\n', file=f)
for i in range(0,atomnumber):
   print( i+1,cc , int(typ1[int(iDm[i])]),charge[int(typ1[int(iDm[i])])],x1[int(iDm[i])],y1[int(iDm[i])],z1[int(iDm[i])], file=f)
   if (i+1)%3==0:
       cc=cc+1
  # print( int(iD[i]), int(mol[i]), int(typ[i]),charge[i],x1[i],y1[i],z1[i], file=f)


##############################################Bonds########################
print ("\n", file=f)
always_print = False
with open("supercell-order.data") as f3:
    for line in f3:
        line  = line.rstrip('\n')
        if line.startswith("Bonds"):
           print (line, file=f)
           for i in range(numberbonds+1):
              print (next(f3).rstrip('\n'), file=f)
 
print ("\n", file=f)
with open("supercell-order.data") as f3:
    for line in f3:
        line  = line.rstrip('\n')
        if line.startswith("Angles"):
           print (line, file=f)
           for i in range(numberangles+1):
              print (next(f3).rstrip('\n'), file=f)


f.close() 
