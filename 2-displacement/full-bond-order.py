# this only works for ice-II
from __future__ import print_function
import numpy as np
from numpy import *
from decimal import *
from ase.io import read
from ase import Atoms
import os

dim=os.environ["dim"]
atoms = read('ice-opt-atom-1.000000.traj', index=-1)
cell = float(dim[0])*atoms.get_cell()


numberline = 1
f3 =  open('supercell.data')
for line in f3:
  numberline  = numberline +1
  if line.startswith("Atoms"):
     break

xypard = 0.0
xzpard = 0.0
yzpard = 0.0
f = open("supercell-order.data", "w")
with open("supercell.data") as f3:
    for line in f3:
        line  = line.rstrip('\n')
        if "atoms" in line:
             atoms=line.rstrip('\n').split(" ")
             print ("\n", file=f)
             print (line, file=f)
             print ("2 atom types", file=f)
             print (int(atoms[0])*2/3," bonds", file=f)
             print ("1 bond types", file=f)
             print (int(atoms[0])/3," angles", file=f)
             print ("1 angle types", file=f)
             print ("\n", file=f)
        if "xlo" in line:
             xpard = line.split(" ")
             print (line, file=f)
        if "ylo" in line:
             ypard = line.split(" ")
             print (line, file=f)
        if "zlo" in line:
             zpard = line.split(" ")
             print (line, file=f)
        if "xy" in line:
             trilin = line.split(" ")
             print (line, file=f)
             print ("\n", file=f)
             xypard = float(trilin[0])
             xzpard = float(trilin[1])
             yzpard = float(trilin[2])
             

atomnumber= int(atoms[0])
xpard= -float(xpard[0]) + float(xpard[1])
ypard= -float(ypard[0])+ float(ypard[1])
zpard= -float(zpard[0])+ float(zpard[1])

n_atoms=atomnumber
bondlenght=1.4
oxygen=2.0
hydrogen=1.0
out = np.zeros(atomnumber)
mol= 99999*np.ones(n_atoms)
charge= np.zeros(n_atoms)
dis = np.ones((n_atoms,n_atoms))*100

iD = np.zeros(atomnumber)
sh = np.zeros(atomnumber)
sha = np.zeros(atomnumber)
hout = np.zeros(atomnumber)
bond = np.zeros(shape=(atomnumber,atomnumber))
charge= np.zeros(atomnumber)
data = np.genfromtxt("supercell.data", skip_header=numberline, max_rows=atomnumber)

#a,mol,typ,charge,x,y,z = data[:,0],data[:,1],data[:,2],data[:,3],data[:,4],data[:,5],data[:,6]

#"""

typ,x,y,z = data[:,1], data[:,2], data[:,3], data[:,4] 

for i in range(1,n_atoms):
   for j in range(0,i-1):
             D = np.array([(x[i]-x[j]),(y[i]-y[j]),(z[i]-z[j])])
             D_len = np.array([np.sqrt((D**2).sum())])
             dis[i][j]= D_len
             dis[j][i]=dis[i][j]
kk=0
for i in range(0,atomnumber):
   if typ[i]==oxygen:
       kk= kk+1
       mol[i] = kk
       if typ[int(dis[:,i].argsort()[:2][0])]==hydrogen:
	    if dis[int(dis[:,i].argsort()[:2][0])][i]<bondlenght:
		mol[int(dis[:,i].argsort()[:2][0])] = kk
	    else:
		out[i]=1
       else:
	    out[i]=1
       if typ[int(dis[:,i].argsort()[:2][1])]==hydrogen:
	    if dis[int(dis[:,i].argsort()[:2][1])][i]<bondlenght:
		mol[int(dis[:,i].argsort()[:2][1])] = kk
	    else:
		out[i]=1
       else:
	    out[i]=1

from ase.geometry import (wrap_positions, find_mic, cellpar_to_cell,
                          cell_to_cellpar)

for i in range(0,atomnumber):
   if mol[i]==99999:
      for j in range(0,atomnumber):
	   if out[j]==1:
                    D = np.array([(x[i]-x[j]),(y[i]-y[j]),(z[i]-z[j])])
                    D, D_len = find_mic([D], cell, [1,1,1])
		    dis[i][j]= D_len[0]


kk=0
for i in range(0,n_atoms):
   if typ[i]==oxygen:
       kk= kk+1
       mol[i] = kk
       if typ[int(dis[:,i].argsort()[:2][0])]==hydrogen:
	    if dis[int(dis[:,i].argsort()[:2][0])][i]<bondlenght:
		mol[int(dis[:,i].argsort()[:2][0])] = kk
       if typ[int(dis[:,i].argsort()[:2][1])]==hydrogen:
	    if dis[int(dis[:,i].argsort()[:2][1])][i]<bondlenght:
		mol[int(dis[:,i].argsort()[:2][1])] = kk




 # charge for each atom type

for i in range(0,atomnumber):
    if typ[i]==oxygen:
	charge[i]=-0.8476
    if typ[i]==hydrogen: 
	charge[i]=0.4238

#"""

                     
bb=1
ll=1
# print coordinate  
print( '\nAtoms\n', file=f)               
for i in range(0,atomnumber):
    if typ[i]==oxygen:
	for j in range(0,atomnumber):
	    if i!=j:
		if mol[i] == mol[j]:
		    for k in range(0,atomnumber):
			if k!=j:
			    if k!=i:
			       if mol[i] == mol[k]:
				 if ll%2!=0:
				    print( bb, int(mol[i]), int(typ[i]),charge[i],x[i],y[i],z[i],i, file=f)
				    iD[i]=bb
				    print( bb+1, int(mol[j]), int(typ[j]),charge[j],x[j],y[j],z[j],j, file=f)
				    iD[j]=bb+1
				    print( bb+2, int(mol[k]), int(typ[k]),charge[k],x[k],y[k],z[k],k, file=f)
				    iD[k]=bb+2
				    bb= bb+3
				 ll= ll+1

# print bonds
bb=1
print ('\nBonds\n', file=f)
for i in range(0,atomnumber):
    if typ[i]==oxygen:
	for j in range(0,atomnumber):
	    if i!=j:
		if mol[i] == mol[j]:
		   print (bb,1,int(iD[i]),int(iD[j]), file=f) 
		   bb= bb+1
    
# print angles 
bb=1
ll=1
print ('\nAngles\n', file=f)
for i in range(0,atomnumber):
    if typ[i]==oxygen:
	for j in range(0,atomnumber):
	    if i!=j:
		if mol[i] == mol[j]:
		    for k in range(0,atomnumber):
			if k!=j:
			    if k!=i:
			       if mol[i] == mol[k]:
				 if ll%2!=0: 
				    print( bb,1,int(iD[j]),int(iD[i]), int(iD[k]), file=f) 
			            bb= bb+1
			         ll= ll+1



print ("\n", file=f)
numberlinemasses=0
always_print = False
with open("supercell.data") as f3:
    for line in f3:
        line  = line.rstrip('\n')
        if always_print or line.startswith("Masses"):
            numberlinemasses  = numberlinemasses +1
            print (line, file=f)
            always_print = True
            if numberlinemasses > 3:
                always_print = False

f.close()        
