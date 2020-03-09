
awk '{print $1*33.35641 " " $2}' total_dos.dat-ih > total_dos.dat-ih-s


#/home/soroush/gnuplot-5.2.6/bin/gnuplot -persist <<-EOFMarker
gnuplot -persist <<-EOFMarker

set key autotitle columnhead font 'Arial-Bold,20' out horiz top 
#set key samplen 6
set xrange [ 0: 3800 ]
set encoding iso_8859_1
set ylabel 'Density of State' font 'Arial-Bold, 15' offset +2
set xlabel 'Frequency (cm^{-1})' font 'Arial-Bold, 15' offset -1
set tics font 'Arial-Bold,15'
set ytics 0, 5, 20
set border lw 1.5
set size ratio 0.51
unset key
unset logscale y
set grid
set grid lc rgb '#D3D3D3  lw 0.51
set terminal postscript portrait enhanced color dashed lw 1.5 font 'Arial-Bold, 20'	
set output "ih-tip4pf.ps"

plot "total_dos.dat-ih-s" using 1:2 with lines lw 2 lc rgb 'red', 

EOFMarker

ps2pdf ih-tip4pf.ps
#mail -a ih-tip4pf.pdf -s "dos" s.rasti@lic.leidenuniv.nl < /dev/null
