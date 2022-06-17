# Zshrc file

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# This is faster than `autoload -U compinit && compinit`
autoload -Uz compinit

zcompdump_current() {
  if [[ $(uname -s) == 'Darwin' ]]; then
    [ "$(date +'%s')" != "$(stat -f '%Y' -t '%j' $HOME/.zcompdump)" ];
  else
    [ "$(date +'%s')" != "$(stat -c '%Y' $HOME/.zcompdump)" ];
  fi
}

if zcompdump_current; then
  compinit
else
  compinit -C
fi

# For my dotfiles repo to work correctly the paths to source'd files must be
# relative to the location of this file. This doesn't handle cases where the
# .zshrc is symlinked to a symlink.
# Taken from http://stackoverflow.com/a/26492107/1245380
ZSHRC_PATH=$(dirname "$(readlink "${(%):-%N}")")

# This is faster than loading all of oh-my-zsh
source $ZSH/lib/functions.zsh
source $ZSH/lib/theme-and-appearance.zsh
source $ZSH/lib/git.zsh
source $ZSH/lib/history.zsh
source $ZSH/lib/key-bindings.zsh
source $ZSH/lib/completion.zsh
source $ZSH/lib/misc.zsh
source $ZSH/plugins/gitfast/gitfast.plugin.zsh
source $ZSHRC_PATH/zsh/blinks-modified.zsh-theme

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git tmuxinator rails)

DISABLE_CORRECTION="true"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# We need this so that tmux uses zsh when started in a zsh shell
export SHELL='/bin/zsh'

source $ZSHRC_PATH/mixins/general
source $ZSHRC_PATH/mixins/functions
source $ZSHRC_PATH/mixins/grep
source $ZSHRC_PATH/mixins/path
source $ZSHRC_PATH/mixins/asdf
source $ZSHRC_PATH/mixins/aliases
source $ZSHRC_PATH/mixins/man_color

# Use asdf autocompletions
. $HOME/.asdf/completions/_asdf

# Save all history
# Incrementally write history to file
setopt INC_APPEND_HISTORY
# Save timestamp to history file too
setopt EXTENDED_HISTORY
# Import newly written commands from the history file
setopt SHARE_HISTORY

precmd() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history | tail -n 1)" >>! $HOME/history/zsh-history-$(date "+%Y-%m-%d").log;
    fi
}

# Use vi mode
bindkey -v

# Vi mode settings
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Easier, more vim-like editor opening
# `v` is already mapped to visual mode, so we need to use a different key to
# open Vim
bindkey -M vicmd "^V" edit-command-line

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1
