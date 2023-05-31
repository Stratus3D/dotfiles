# Some inspiration taken from https://github.com/hesstobi/Gnuplot-Templates/blob/master/defaults.gp
# Colors follow guidelines from this article - https://blog.datawrapper.de/beautifulcolors/

# Never remove a command from Gnuplot's command history
set history size -1

# Use utf8 everywhere
set encoding utf8

# Increase samples for smoother lines
set samples 3000
set isosamples 30

# Macros aren't enabled by default but I use them occassionally
set macros

# Variables
# recommended by Gnuplot in Action, similar to Helvetica
font = "Nimbus Sans L,16" # Or "Helvetica,16"

# date/time variables
times = "set xdata time; set xtics format '%T'; set timefmt '%H:%M:%S'"
dates = "set xdata time; set xtics format '%F'; set timefmt '%Y-%m:%d'"

# Functions
# Color management functions, not sure if I really need these
hsv(h, s, v) = hsv2rgb(h - floor(h), s, v)
pack(r, g, b) = 2**16*r + 2**8*g + b

# Use qt terminal by default, with font setting
set terminal qt font font

# Line settings
set termoption linewidth 1.4

# By default make titles bigger
set title font ", 20"

# By default render a grid for the plot
set grid

# Add custom scripts to the loadpath
set loadpath "~/dotfiles/scripts/gnuplot"

# I've found this to be slightly better than the default colorsequence
# Also appears to match the recommended by the book, Fundamentals of Data
# Visualization. https://jfly.uni-koeln.de/color/
set colorsequence podo
