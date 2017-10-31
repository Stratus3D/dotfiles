#! /usr/bin/env bash

# I wish I could put this in ssh/config but it doesn't appear to be possible

function sshmux {
    # Pass all arguments directly to `ssh` and add the tmux command
    ssh $@ -t 'tmux has-session && exec tmux attach || exec tmux; exec $(tmux showenv -s)'
}
