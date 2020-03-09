
from __future__ import print_function
import numpy as np
from ase.io import Trajectory
from ase.io import read
import spglib
import os








a = read('ice-qha-1.000000-.traj', index=-1)
f = open("volume.dat", "w")
#stress = np.max(a.get_stress()) 
#force = np.max(a.get_forces())
volume= a.get_volume()
energy= a.get_potential_energy()
print (volume*3/len(a), energy, file=f)
