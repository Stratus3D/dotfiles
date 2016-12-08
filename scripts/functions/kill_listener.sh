#! /bin/bash -

# Kills a process listening on a port

kill_listener() {
    port=$1
    lsof -i :$port -s TCP:LISTEN -t | xargs kill
}
