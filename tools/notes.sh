#! /bin/bash

# Provides a simple interface for view notes left by the programming in a
# projects source code. Modelled after the rake notes task.

usage() {
    cat <<EOF
    Usage: notes.sh [command]

    Commands:
    todo       Print out the TODO lines in the source code contained in the dir
    fixme      Print out the FIXME lines in the source code contained in the dir
    optimize   Print out the OPTIMIZE lines in the source code contained in the dir
EOF
}

find_notes() {
    # Take keyword and pass it to `ag`. Then edit the output of `ag` to remove
    # any unnecessary syntax from the line.
    # TODO: Figure out how to get `ag` to print multi-line results when using pipe
    ag $1 --group --color | sed 's/\:\+'"$1"'//'
}

if [ $# -gt 0 ]; then
    lower_command=$(echo $1 | awk '{print tolower($0)}');
    case $lower_command in
        'todo')
            find_notes TODO;;
        'fixme')
            find_notes FIXME;;
        'optimize')
            find_notes OPTIMIZE;;
        *)
            usage;;
    esac
else
    usage;
fi
