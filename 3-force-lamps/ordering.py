from __future__ import print_function
import numpy as np
from numpy import *
from ase.io import read
import math
from ase import Atoms
import os


dim=os.environ["dim"]
atoms = read('ice-opt-atom-1.000000.traj', index=-1)
cell = float(dim[0])*atoms.get_cell()

numberline = 0
f1 =  open('supercell-001.dump')
for line in f1:
  numberline  = numberline +1
  if "id" in line:
     break

numberline1 = 1
f4 =  open("supercell-001.data")
for line in f4:
  numberline1  = numberline1 +1
  if line.startswith("Atoms"):
     break





xypard = 0.0
xzpard = 0.0
yzpard = 0.0
with open("supercell-001.data") as f3:
    for line in f3:
        line  = line.rstrip('\n')
        if "atoms" in line:
             atoms=line.rstrip('\n').split(" ")
        if "xlo" in line:
             xpard = line.split(" ")
        if "ylo" in line:
             ypard = line.split(" ")
        if "zlo" in line:
             zpard = line.split(" ")
        if "xy" in line:
             trilin = line.split(" ")
             xypard = float(trilin[0])
             xzpard = float(trilin[1])
             yzpard = float(trilin[2])
             

atomnumber= int(atoms[0])
xpard= -float(xpard[0]) + float(xpard[1])
ypard= -float(ypard[0])+ float(ypard[1])
zpard= -float(zpard[0])+ float(zpard[1])

#####################################################################################
oxygen=2
hydrogen=1

data = np.genfromtxt("supercell-001.dump", skip_header=numberline, max_rows=atomnumber)
data1 = np.genfromtxt("supercell-001.data", skip_header=numberline1, max_rows=atomnumber)
ATOM,typ,x,y,z,vx,vy,vz,fx,fy,fz = data[:,0],data[:,1],data[:,2],data[:,3],data[:,4],data[:,5],data[:,6],data[:,7],data[:,8],data[:,9],data[:,10]
ATOM1,typ1,x1,y1,z1 = data1[:,0],data1[:,1], data1[:,2], data1[:,3], data1[:,4]

#####################################################################################





####################################print###############################################




f = open("supercell-001.dump", "w")


print ('ITEM: TIMESTEP', file=f)
print (0, file=f)
print ('ITEM: NUMBER OF ATOMS', file=f)
print (atomnumber, file=f)
print ('ITEM: BOX BOUNDS xy xz yz xx yy zz', file=f)
print (0.0000000000000000e+00, xpard, xypard, file=f)
print (0.0000000000000000e+00, ypard, xzpard  , file=f)
print (0.0000000000000000e+00, zpard, yzpard, file=f)
print ('ITEM: ATOMS id type x y z vx vy vz fx fy fz', file=f)

#########################################################################
from ase.geometry import (wrap_positions, find_mic, cellpar_to_cell,
                          cell_to_cellpar)

cor=9999999*np.ones(atomnumber)

for i in range(0,atomnumber):
   for j in range(0,atomnumber):
      if typ[j]==typ1[i]: 
         D = np.array([(x1[i]-x[j]),(y1[i]-y[j]),(z1[i]-z[j])])
         D_len = np.array([np.sqrt((D**2).sum())])
         if D_len<0.1:
             cor[i]=j
             break
         
for i in range(0,atomnumber):
   if cor[i]==9999999:
       for j in range(0,atomnumber):
            if typ[j]==typ1[i]: 
                 D = np.array([(x1[i]-x[j]),(y1[i]-y[j]),(z1[i]-z[j])])
                 D, D_len = find_mic([D], cell, [1,1,1])
                 if D_len[0]<0.2:
                         cor[i]=j
                         break
for i in range(0,atomnumber):
               print( int(ATOM1[i]),int(typ1[i]),x1[i],y1[i],z1[i],vx[int(cor[i])],vy[int(cor[i])], vz[int(cor[i])], fx[int(cor[i])], fy[int(cor[i])], fz[int(cor[i])], file=f)


f.close() 
