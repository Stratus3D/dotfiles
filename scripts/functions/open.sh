#! /usr/bin/env bash

# Functions for opening various things from the command line

os=$(uname -s)

# If we aren't on OSX create an `open` alias so we can use `open` on both OSes
if [[ "$os" = 'Linux' ]]; then
    function open() {
        xdg-open $@
    }
fi

search_string() {
    search=""

    for term in "$@"; do
        search="$search%20$term"
    done

    echo "$search"
}

function goo() {
    search_string "$@"
    open "http://www.google.com/search?q=$(search_string "$@")"
}

function duc() {
    search_string "$@"
    open "http://www.duckduckgo.com?q=$(search_string "$@")"
}

function open_ticket() {
  if [ -n "$BASE_TICKET_URL" ]; then
    open "$BASE_TICKET_URL$1"
  else
    echo "BASE_TICKET_URL is not set"
    return 1
  fi
}
