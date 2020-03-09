#!/bin/bash


#export PYTHONPATH=~/phonopy-bond/lib/python/:$PYTHONPATH
#export PATH=~/phonopy-bond/bin:$PATH
export PYTHONPATH=~/phonopy/lib/python/:$PYTHONPATH
export PATH=~/phonopy/bin:$PATH
rm total_dos.dat
cp disp.yaml-1.000000 disp.yaml
cp intial.data-1.000000 intial.data
cp FORCE_SETS-1.000000 FORCE_SETS
phonopy dos.conf  --lammps  --dim="2 2 2"
mail -a total_dos.dat  -s "total_dos" s.rasti@lic.leidenuniv.nl < /dev/null
