source $HOME/dotfiles/mixins/general
source $HOME/dotfiles/mixins/asdf
source $HOME/dotfiles/mixins/functions
source $HOME/dotfiles/mixins/aliases
source $HOME/dotfiles/mixins/grep
source $HOME/dotfiles/mixins/path
source $HOME/dotfiles/mixins/man_color

# Use asdf autocompletions
. $HOME/.asdf/completions/asdf.bash

# We need this so that tmux uses bash when started in a bash shell
export SHELL=/bin/bash

# Append to the history file, don't overwrite it
shopt -s histappend

# Keep all history
export HISTFILESIZE=
export HISTSIZE=
export HISTFILE=~/.bash_eternal_history

# Don't store duplicate commands and commands prefixed by a space
export HISTCONTROL=ignoreboth

# Also write history to files in the history/ directory
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> $HOME/history/bash-history-$(date "+%Y-%m-%d").log; fi'

# Use vi mode
set -o vi
