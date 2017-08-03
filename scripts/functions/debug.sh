#! /usr/bin/env bash

# A simple debug function that can be used inside shell scripts to pause
# execution and allow for inspection of the environment and execution of
# commands.

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
