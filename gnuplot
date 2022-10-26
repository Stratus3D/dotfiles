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


# Font settings
set terminal qt font "Helvetica,16"

# Line settings
set termoption linewidth 1.4


# By default render a grid for the plot
set grid

# Add custom scripts to the loadpath
set loadpath "~/dotfiles/scripts/gnuplot"
