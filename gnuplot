# Some inspiration taken from https://github.com/hesstobi/Gnuplot-Templates/blob/master/defaults.gp
# Colors follow guidelines from this article - https://blog.datawrapper.de/beautifulcolors/

set macros

#png="set terminal png size 1800,1800 crop enhanced font \"/usr/share/fonts/truetype/times.ttf,30\" dashlength 2; set termoption linewidth 3"
#eps="set terminal postscript fontfile \"/usr/share/fonts/truetype/times.ttf\"; set termoption linewidth 3;

# Font settings
set terminal qt font "Helvetica,16"

# Line settings
set termoption linewidth 1.4

# 8 line colors
# dashtypes
#
set style line 1 linecolor rgb '#de181f' linetype 1  # Red
set style line 2 linecolor rgb '#0060ae' linetype 1  # Blue
set style line 3 linecolor rgb '#228C22' linetype 1  # Forest green

set style line 4 linecolor rgb '#18ded7' linetype 1  # opposite Red
set style line 5 linecolor rgb '#ae4e00' linetype 1  # opposite Blue
set style line 6 linecolor rgb '#8c228c' linetype 1  # opposite Forest green

# Default to a line width of 2
#do for [i=1:100] {
#    set style line i linewidth 2
#}
