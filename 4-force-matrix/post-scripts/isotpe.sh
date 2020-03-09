#!/bin/bash


export PYTHONPATH=~/phonopy/lib/python/:$PYTHONPATH
export PATH=~/phonopy/bin:$PATH
rm -r d2o
mkdir d2o
cp thermal.conf d2o/.
cp e-v.dat d2o/.
cp 4-qha.sh d2o/.
for a in $(seq 0.960000  0.008 1.040000)
do
    cp FORCE_SETS-$a d2o/FORCE_SETS
    cp  disp.yaml-$a d2o/disp.yaml
    cp intial.data-$a  d2o/intial.data
    cd d2o
    phonopy thermal.conf  --lammps  --dim="2 2 2"
    cp thermal_properties.yaml thermal_properties.yaml-$a
    cd ..
done
cd d2o
./4-qha.sh
cd ..
