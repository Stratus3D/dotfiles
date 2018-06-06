#! /usr/bin/env bash

# Functions for opening various things from the command line

os=$(uname -s)

# If we aren't on OSX create an `open` alias so we can use `open` on both OSes
if [[ "$os" = 'Linux' ]]; then
    function open() {
        xdg-open $@
    }
fi

