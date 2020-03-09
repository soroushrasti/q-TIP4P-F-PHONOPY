#!/bin/bash


export PYTHONPATH=~/phonopy/lib/python/:$PYTHONPATH
export PATH=~/phonopy/bin:$PATH
rm -r h2-18o
mkdir h2-18o
cp thermal18.conf h2-18o/.
cp e-v.dat h2-18o/.
cp 4-qha.sh h2-18o/.
for a in $(seq 0.960000  0.008 1.040000)
do
    cp FORCE_SETS-$a h2-18o/FORCE_SETS
    cp  disp.yaml-$a h2-18o/disp.yaml
    cp intial.data-$a  h2-18o/intial.data
    cd h2-18o
    phonopy thermal18.conf  --lammps  --dim="2 2 2"
    cp thermal_properties.yaml thermal_properties.yaml-$a
    cd ..
done
cd h2-18o
./4-qha.sh
cd ..
