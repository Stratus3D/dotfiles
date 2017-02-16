#! /bin/bash -

# Check if the file extension was provided
if [ $# -lt 1 ]; then
    cat <<EOF
    Usage: `basename "$0"` [file_extension]
EOF
    exit 1;
fi

# If we get past the if condition we find all files with the given extension
FILES=$(find . -iname "*.$1")

# Then we count the lines in all those files
cat $FILES | wc -l
