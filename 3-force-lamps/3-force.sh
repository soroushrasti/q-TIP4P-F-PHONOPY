#!/bin/bash

rm supercell*.data
rm supercell*.dump
../link-order.sh
numberfiles=$(ls -lR supercell-order-*.data | wc -l)
a=$((numberfiles-1))
for i in `seq 0 $a`;
              do
                             j=$((i+1))
                             if [ "$i" -gt "9" ] && [ "$i" -lt "99" ];
                                 then
                                 sed -i "s/supercell-order-0$i.data/supercell-order-0$j.data/" in.force
                                 sed -i "s/supercell-0$i.dump/supercell-0$j.dump/"  in.force 
                                 sed -i "s/supercell-0$i.data/supercell-0$j.data/" ordering.py
                                 sed -i "s/supercell-0$i.dump/supercell-0$j.dump/"  ordering.py 
                             fi
                             if [ "$i" -eq "9" ];
                                 then
                                 sed -i "s/supercell-order-00$i.data/supercell-order-0$j.data/" in.force
                                 sed -i "s/supercell-00$i.dump/supercell-0$j.dump/"  in.force  
                                 sed -i "s/supercell-00$i.data/supercell-0$j.data/" ordering.py
                                 sed -i "s/supercell-00$i.dump/supercell-0$j.dump/"  ordering.py 
                             fi
                             if [ "$i" -lt "9" ];
                                 then
                                 sed -i "s/supercell-order-00$i.data/supercell-order-00$j.data/" in.force
                                 sed -i "s/supercell-00$i.dump/supercell-00$j.dump/"  in.force  
                                 sed -i "s/supercell-00$i.data/supercell-00$j.data/" ordering.py
                                 sed -i "s/supercell-00$i.dump/supercell-00$j.dump/"  ordering.py 
                             fi
                             if [ "$i" -eq "99" ];
                                  then
                                  sed -i "s/supercell-order-0$i.data/supercell-order-$j.data/" in.force
                                  sed -i "s/supercell-0$i.dump/supercell-$j.dump/"  in.force  
                                  sed -i "s/supercell-0$i.data/supercell-$j.data/" ordering.py
                                  sed -i "s/supercell-0$i.dump/supercell-$j.dump/"  ordering.py 
                             fi
                             if [ "$i" -gt "99" ];
                                  then
                                  sed -i "s/supercell-order-$i.data/supercell-order-$j.data/" in.force
                                  sed -i "s/supercell-$i.dump/supercell-$j.dump/"  in.force  
                                  sed -i "s/supercell-$i.data/supercell-$j.data/" ordering.py
                                  sed -i "s/supercell-$i.dump/supercell-$j.dump/"  ordering.py 
                             fi
                             echo it is done for $j file
                             ~/lammps/my/src/lmp_serial -i in.force
                             python ordering.py
              done 

if [ "$j" -gt "9" ] && [ "$j" -lt "99" ];
    then
    sed -i "s/supercell-order-0$j.data/supercell-order-001.data/"  in.force
    sed -i "s/supercell-0$j.dump/supercell-001.dump/"  in.force 
    sed -i "s/supercell-0$j.data/supercell-001.data/" ordering.py
    sed -i "s/supercell-0$j.dump/supercell-001.dump/"  ordering.py 
fi
if [ "$j" -eq "9" ];
    then
    sed -i "s/supercell-order-00$j.data/supercell-order-001.data/"  in.force
    sed -i "s/supercell-00$j.dump/supercell-001.dump/"  in.force 
    sed -i "s/supercell-00$j.data/supercell-001.data/" ordering.py
    sed -i "s/supercell-00$j.dump/supercell-001.dump/"  ordering.py 
fi
if [ "$j" -lt "9" ];
    then
    sed -i "s/supercell-order-00$j.data/supercell-order-001.data/"  in.force
    sed -i "s/supercell-00$j.dump/supercell-001.dump/"  in.force 
    sed -i "s/supercell-00$j.data/supercell-001.data/" ordering.py
    sed -i "s/supercell-00$j.dump/supercell-001.dump/"  ordering.py 
fi
if [ "$j" -eq "99" ];
    then
    sed -i "s/supercell-order-0$j.data/supercell-order-001.data/"  in.force
    sed -i "s/supercell-0$j.dump/supercell-001.dump/"  in.force 
    sed -i "s/supercell-0$j.data/supercell-001.data/" ordering.py
    sed -i "s/supercell-0$j.dump/supercell-001.dump/"  ordering.py 
fi
if [ "$j" -gt "99" ];
    then
    sed -i "s/supercell-order-$j.data/supercell-order-001.data/"  in.force
    sed -i "s/supercell-$j.dump/supercell-001.dump/"  in.force 
    sed -i "s/supercell-$j.data/supercell-001.data/" ordering.py
    sed -i "s/supercell-$j.dump/supercell-001.dump/"  ordering.py 
fi

../link-order.sh
