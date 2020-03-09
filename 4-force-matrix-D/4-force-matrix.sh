#!/bin/bash


#export PYTHONPATH=~/phonopy-bond/lib/python/:$PYTHONPATH
#export PATH=~/phonopy-bond/bin:$PATH
export PYTHONPATH=~/phonopy/lib/python/:$PYTHONPATH
export PATH=~/phonopy/bin:$PATH
rm supercell-*.dump*
../link-order.sh

phonopy --lammps  --force_sets supercell-*.dump
phonopy thermal.conf  --lammps  --dim="$dim"
#phonopy band.conf  --lammps  --dim="$dim"

#bandplot --line --dos=total_dos.dat -o band_dos.pdf --xlabel="Wave vector" --ylabel="Frequencies (THz)" --dmin=0 --dmax=20 --fmin=-5.0 --fmax=120 band.yaml
#mail -a band_dos.pdf -s "tip4p-$dim-ice_Ih" s.rasti@lic.leidenuniv.nl < /dev/null
#python bandplot1 --line --dos=total_dos.dat --dos1=/home/soroush/ice-ih-tip4p-surface/4-force-matrix/total_dos.dat -o band_dos.pdf --xlabel="Wave vector" --ylabel="Frequencies (THz)" --dmin=0.0 --dmax=20 --fmin=-5.0 --fmax=60 band.yaml /home/soroush/ice-ih-tip4p-surface/4-force-matrix/band.yaml
