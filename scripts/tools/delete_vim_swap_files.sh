#! /bin/bash -

# Delete vim swap files in directory

# Set flags so script is executed in "strict mode"
set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

usage() {
    cat <<EOF
    Usage
EOF
}

delete_vim_swap_files() {
    find $1 -type f -name "*.swp" -delete
}

if [ -z $1 ]; then
    delete_vim_swap_files
else
    usage
fi
