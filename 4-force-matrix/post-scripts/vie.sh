export PYTHONPATH=~/phonopy-bond/lib/python/:$PYTHONPATH
export PATH=~/phonopy-bond/bin:$PATH

rm output-h
rm d2o/output-d
#for i in $(seq 0.0 0.02 0.5)
for i in $(seq 0.001 0.01 0.2)
do
 #cd 4-force-matrix
 phonopy-qha --pressure $i e-v.dat thermal_properties.yaml-*
  #echo $(grep ' 10.000000000000000' volume-temperature.dat) $i >> output-h 
  echo $(grep '145.000000000000000' volume-temperature.dat) $i >> output-h 
  #cd ..
 cd d2o
 phonopy-qha --pressure $i e-v.dat thermal_properties.yaml-*
  #echo $(grep ' 10.000000000000000' volume-temperature.dat) $i >> output-d 
  echo $(grep '145.000000000000000' volume-temperature.dat) $i >> output-d 
  cd ..
done

paste output-h d2o/output-d > output
awk '{ print $3, 100*($5/$2-1)}' output > outputplot

