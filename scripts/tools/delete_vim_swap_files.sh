#! /bin/bash -

# Delete vim swap files in the given directory

# Set flags so script is executed in "strict mode"
set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

# Variables
directory=${1:-}

usage() {
    cat <<EOF
    Usage: delete_vim_swap_files.sh [directory]
EOF
}

delete_vim_swap_files() {
    directory=${1:-}
    find $directory -type f -name "*.swp" -delete
}

if [ "z" = "z$directory" ]; then
    usage
else
    delete_vim_swap_files $directory
fi
