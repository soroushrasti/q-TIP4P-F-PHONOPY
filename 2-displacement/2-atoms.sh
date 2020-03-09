#!/bin/bash

rm supercell-*.data
export PYTHONPATH=~/phonopy/lib/python/:$PYTHONPATH
export PATH=~/phonopy/bin:$PATH
phonopy --lammps displacement.conf  --dim="$dim"
numberfiles=$(ls -lR supercell-*.data | wc -l)
python full-bond-order.py 
a=$((numberfiles-1))
for i in `seq 0 $a`;
              do
                             j=$((i+1))
                             if [ "$i" -gt "9" ] && [ "$i" -lt "99" ];  
                                 then
                                 sed -i "s/supercell-order-0$i.data/supercell-order-0$j.data/" 2-atoms.py
                                 sed -i "s/supercell-0$i.data/supercell-0$j.data/" 2-atoms.py
                             fi 
                             if [ "$i" -eq "9" ];
                                 then
                                 sed -i "s/supercell-order-00$i.data/supercell-order-0$j.data/" 2-atoms.py
                                 sed -i "s/supercell-00$i.data/supercell-0$j.data/" 2-atoms.py
                             fi 
                             if [ "$i" -lt "9" ];
                                 then
                                 sed -i "s/supercell-order-00$i.data/supercell-order-00$j.data/" 2-atoms.py
                                 sed -i "s/supercell-00$i.data/supercell-00$j.data/" 2-atoms.py
                             fi 
                             if [ "$i" -eq "99" ];
                                  then
                                  sed -i "s/supercell-order-0$i.data/supercell-order-$j.data/" 2-atoms.py
                                  sed -i "s/supercell-0$i.data/supercell-$j.data/" 2-atoms.py
                             fi 
                             if [ "$i" -gt "99" ];
                                  then  
                                  sed -i "s/supercell-order-$i.data/supercell-order-$j.data/" 2-atoms.py
                                  sed -i "s/supercell-$i.data/supercell-$j.data/" 2-atoms.py
                             fi 
                             echo it is done for $j file
                             python 2-atoms.py
            done
 
if [ "$j" -gt "9" ] && [ "$i" -lt "99" ];
    then
    sed -i "s/supercell-order-0$j.data/supercell-order-001.data/"  2-atoms.py
    sed -i "s/supercell-0$j.data/supercell-001.data/"  2-atoms.py
fi 
if [ "$i" -eq "9" ];
    then
    sed -i "s/supercell-order-00$j.data/supercell-order-001.data/"  2-atoms.py
    sed -i "s/supercell-00$j.data/supercell-001.data/"  2-atoms.py
fi 
if [ "$i" -lt "9" ];
    then
    sed -i "s/supercell-order-00$j.data/supercell-order-001.data/"  2-atoms.py
    sed -i "s/supercell-00$j.data/supercell-001.data/"  2-atoms.py
fi 
if [ "$i" -eq "99" ];
    then
    sed -i "s/supercell-order-0$j.data/supercell-order-001.data/"  2-atoms.py
    sed -i "s/supercell-0$j.data/supercell-001.data/"  2-atoms.py
fi 
if [ "$i" -gt "99" ];
    then
    sed -i "s/supercell-order-$j.data/supercell-order-001.data/"  2-atoms.py
    sed -i "s/supercell-$j.data/supercell-001.data/"  2-atoms.py
fi 

../link-order.sh
