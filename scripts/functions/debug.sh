#! /usr/bin/env bash

# A simple debug function that can be used inside shell scripts to pause
# execution and allow for inspection of the environment and execution of
# commands.

# Example usage in a script:

#    #! /usr/bin/env bash
#    # Load the debug function
#    source scripts/functions/debug.sh
#
#    ...
#
#    # Then use it somewhere
#    foobar() {
#        debug # Now I can inspect the variables that were passed into foobar
#    }

function debug
{
    echo "#############|  Entering DEBUG mode  |####################";
    local cmd=""
    while [[ $cmd != "exit" ]]; do
        # read -p is broken on OSX, so I just print the prompt manually
        echo -n "> "
        read cmd
        case $cmd in
            vars ) ( set -o posix ; set );;
            exit ) ;;
            * ) eval "$cmd";;
        esac
    done
    echo "#############|  End of DEBUG mode |####################";
}
