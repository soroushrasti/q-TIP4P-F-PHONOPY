#!/bin/bash


export PYTHONPATH=~/phonopy-bond/lib/python/:$PYTHONPATH
export PATH=~/phonopy-bond/bin:$PATH

#phonopy-qha --pressure 2 --eos='birch_murnaghan'  e-v.dat thermal_properties.yaml-*
#phonopy-qha --save --eos='birch_murnaghan'  e-v.dat thermal_properties.yaml-*
phonopy-qha --save   e-v.dat thermal_properties.yaml-*

#phonopy-qha e-v.dat thermal_properties.yaml-0.960000  thermal_properties.yaml-0.984000  thermal_properties.yaml-1.008000  thermal_properties.yaml-1.032000 thermal_properties.yaml-0.968000  thermal_properties.yaml-0.992000  thermal_properties.yaml-1.016000  thermal_properties.yaml-1.040000 thermal_properties.yaml-0.976000  thermal_properties.yaml-1.000000  thermal_properties.yaml-1.024000
#rm supercell-*.dump
#../link.sh
#phonopy --lammps --force_sets supercell-*.dump
#phonopy dos.conf  --lammps  --dim="$dim" --tolerance=1e-4
#phonopy qha.conf  --lammps  --dim="$dim" --tolerance=1e-4
#phonopy band.conf  --lammps  --dim="$dim" --tolerance=1e-4
#phonopy total_dos.conf  --lammps  --dim="4 4 1"
#phonopy band.conf  --lammps  --dim="4 4 1"

#bandplot --line --dos=total_dos.dat -o band_dos.pdf --xlabel="Wave vector" --ylabel="Frequencies (THz)" --dmin=0.0 --dmax=20 --fmin=-5.0 --fmax=60 band.yaml
#mail -a band_dos.pdf -s "phonon-$dim-$scale_number-" s.rasti@lic.leidenuniv.nl < /dev/null
