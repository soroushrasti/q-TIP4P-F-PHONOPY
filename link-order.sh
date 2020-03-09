#!/bin/bash -l

# This serial script links the WFN files from the MF to the BGW folder.




echo " Working on directory 2-dispalcement"
cd ../2-displacement/
ln -sf ../1-lamps-minimiz/intial.data  intial.data 
cd ../

cd 3-force-lamps
  echo " Working on 3-force-lamps"
  ln -sf ../2-displacement/disp.yaml disp.yaml
  ln -sf ../2-displacement/supercell-*.data ../3-force-lamps/
  ln -sf ../2-displacement/supercell-order-*.data ../3-force-lamps/
  ln -sf ../2-displacement/ice-opt-atom-1.000000.traj ice-opt-atom-1.000000.traj
  cd ../
cd 4-force-matrix
  echo " Working on 4-force-matrix"
  ln -sf ../2-displacement/disp.yaml disp.yaml
  ln -sf ../2-displacement/intial.data intial.data
  ln -sf ../2-displacement/ice-opt-atom-1.000000.traj ice-opt-atom-1.000000.traj
  ln -sf ../3-force-lamps/*.dump ../4-force-matrix/
cd ../

cd 4-force-matrix-D
  echo " Working on 4-force-matrix"
  ln -sf ../2-displacement/disp.yaml disp.yaml
  ln -sf ../2-displacement/intial.data intial.data
  ln -sf ../2-displacement/ice-opt-atom-1.000000.traj ice-opt-atom-1.000000.traj
  ln -sf ../3-force-lamps/*.dump ../4-force-matrix-D/
cd ../

echo "done"

