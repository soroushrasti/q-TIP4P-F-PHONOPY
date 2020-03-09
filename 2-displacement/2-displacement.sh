#!/bin/bash


export PYTHONPATH=~/phonopy-bond-order/lib/python/:$PYTHONPATH
export PATH=~/phonopy-bond-order/bin:$PATH
rm supercell-*.data
rm supercell-*.data~
#phonopy --lammps displacement.conf  --dim="4 4 1"
phonopy --lammps displacement.conf  --dim="$dim"
numberfiles=$(ls -lR supercell-*.data | wc -l)
a=$((numberfiles-1))
for i in `seq 0 $a`;
              do
                             j=$((i+1))
                             if [ "$i" -gt "9" ] && [ "$i" -lt "99" ];  
                                 then
                                 sed -i "s/supercell-0$i.data/supercell-0$j.data/" 2-displacement.py
                             fi 
                             if [ "$i" -eq "9" ];
                                 then
                                 sed -i "s/supercell-00$i.data/supercell-0$j.data/" 2-displacement.py
                             fi 
                             if [ "$i" -lt "9" ];
                                 then
                                 sed -i "s/supercell-00$i.data/supercell-00$j.data/" 2-displacement.py
                             fi 
                             if [ "$i" -eq "99" ];
                                  then
                                  sed -i "s/supercell-0$i.data/supercell-$j.data/" 2-displacement.py
                             fi 
                             if [ "$i" -gt "99" ];
                                  then  
                                  sed -i "s/supercell-$i.data/supercell-$j.data/" 2-displacement.py
                             fi 
                             echo it is done for $j file
                             python 2-displacement.py
            done
 
if [ "$j" -gt "9" ] && [ "$i" -lt "99" ];
    then
    sed -i "s/supercell-0$j.data/supercell-001.data/"  2-displacement.py
fi 
if [ "$i" -eq "9" ];
    then
    sed -i "s/supercell-00$j.data/supercell-001.data/"  2-displacement.py
fi 
if [ "$i" -lt "9" ];
    then
    sed -i "s/supercell-00$j.data/supercell-001.data/"  2-displacement.py
fi 
if [ "$i" -eq "99" ];
    then
    sed -i "s/supercell-0$j.data/supercell-001.data/"  2-displacement.py
fi 
if [ "$i" -gt "99" ];
    then
    sed -i "s/supercell-$j.data/supercell-001.data/"  2-displacement.py
fi 

../link.sh
