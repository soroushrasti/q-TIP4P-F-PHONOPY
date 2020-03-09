import numpy as np

from ase import Atoms
from ase.io.trajectory import Trajectory
from ase.io import read
from ase.units import kJ
from ase.eos import EquationOfState, vinet


numberline = 0
f3 =  open('e-v.dat')
for line in f3:
  numberline  = numberline +1

energies=np.zeros(numberline)
volumes=np.zeros(numberline)
i=0
with open("e-v.dat") as f3:
    for line in f3:
        line  = line.rstrip('\n')
        volumes[i],energies[i] = line.split(" ")
        i=i+1

eos = EquationOfState(volumes, energies,  eos='vinet')
eos.fit()
e0, B, Bp, v0 = eos.eos_parameters
fp = open("helmholtz-volume.dat")
for i, line in enumerate(fp):
    if i == 1:
      a,b,Fmin,d,e,V=line.split()
fp.close()
print (float(Fmin)-vinet(float(V),e0,B,Bp,v0)),
#print eos
#v0, e0, B= eos.fit()

