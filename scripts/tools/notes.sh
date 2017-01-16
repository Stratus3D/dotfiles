#! /bin/bash -

# Provides a simple interface for view notes left by the programming in a
# projects source code. Modelled after the rake notes task.
#
# TODO:
# * Add color to the output of the script `source $HOME/dotfiles/scripts/utility/bash_colors.sh`
# * Handle multiline TODOs.
# * Take a directory as an additional argument.

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

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
    # Take keyword and pass it to `ag`.
    ag $1 --group --color
}

print_todos() {
    # Edit the output of `ag` to remove any unnecessary syntax from the line.
    find_notes todo | sed '1,$s/:.*TODO\(:\)\{0,1\}/:/
    1,$s/:.*todo\(:\)\{0,1\}/:/'
}

print_fixmes() {
    # Edit the output of `ag` to remove any unnecessary syntax from the line.
    find_notes fixme | sed '1,$s/:.*FIXME\(:\)\{0,1\}/:/
    1,$s/:.*fixme\(:\)\{0,1\}/:/'
}

print_optimizes() {
    # Edit the output of `ag` to remove any unnecessary syntax from the line.
    find_notes optimize | sed '1,$s/:.*OPTIMIZE\(:\)\{0,1\}/:/
    1,$s/:.*optimize\(:\)\{0,1\}/:/'
}

if [ $# -gt 0 ]; then
    lower_command=$(echo $1 | awk '{print tolower($0)}');
    case $lower_command in
        'todo')
            print_todos;;
        'fixme')
            print_fixmes;;
        'optimize')
            print_optimizes;;
        *)
            usage;;
    esac
else
    usage;
fi
