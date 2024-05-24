# My zsh configuration is designed to be as lean as possible while still giving
# me all the features I need, like autocomplete and git integration.
#
# Commands helpful when building zsh config
#
# * bindkey -l - List all keymaps available
# * bindkey -M <keymap> - Show all bindings in a keymap
# * setopt - show zsh options that are set
#
# Helpful widgets
#
# * where-is - show what keystrokes a particular widget is bound to
# * describe-key-briefly - show escape sequence for keystroke
#
# References
#
# * https://ohmyz.sh/
# * https://thevaluable.dev/zsh-install-configure-mouseless/
# * https://thevaluable.dev/zsh-line-editor-configuration-mouseless/
# * https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
# * https://zsh.sourceforge.io/Doc/Release/Options.html#Option-Aliases
# * https://thevaluable.dev/zsh-completion-guide-examples/

# GENERAL
# ----------

# Print jobs in long format
setopt LONG_LIST_JOBS

# Allow comments in interactive shells
setopt INTERACTIVE_COMMENTS

# NAVIGATION
# ----------

# Navigate to directory by name without using cd
setopt AUTO_CD

# Automatically push directories to the stack when cd'ing
setopt AUTO_PUSHD

# Don't store duplicates on the stack
setopt PUSHD_IGNORE_DUPS

# Swap the meaning of cd +1 and cd -1
setopt PUSHD_MINUS

# Don't print the directory stack when pushing or popping
setopt PUSHD_SILENT

# COMPLETION
# ----------

# Not sure if I want to keep these settings
setopt ALWAYS_TO_END
setopt COMBINING_CHARS
setopt COMPLETE_IN_WORD

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

# Load antigen
source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).

# Faster than the regular git plugin
antigen bundle gitfast
antigen bundle history
antigen bundle key-bindings
antigen bundle completion
antigen bundle misc

# For tmuxinator completions
antigen bundle tmuxinator

# zsh syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Don't allow zsh to autocorrect commands
DISABLE_CORRECTION="true"

# We need this so that tmux uses zsh when started in a zsh shell
export SHELL='/bin/zsh'

DOTFILES_DIR=$HOME/dotfiles

source $DOTFILES_DIR/mixins/general
source $DOTFILES_DIR/mixins/functions
source $DOTFILES_DIR/mixins/grep
source $DOTFILES_DIR/mixins/path
source $DOTFILES_DIR/mixins/asdf
source $DOTFILES_DIR/mixins/aliases
source $DOTFILES_DIR/mixins/man_color

# Use asdf autocompletions
. $HOME/.asdf/completions/_asdf

# HISTORY
# ----------

# There is no way to define history size as infinite so we set it to 1 billion
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# Prefer unique commands in history
# If the internal history needs to be trimmed to add the current command line,
# setting this option will cause the oldest history event that has a duplicate
# to be lost before losing a unique event from the list.
setopt HIST_EXPIRE_DUPS_FIRST

# Do not enter command lines into the history list if they are duplicates of the previous event.
setopt HIST_IGNORE_DUPS

# Don't save commands to history when they start with a space, or when the alias
# contains a leading space
setopt HIST_IGNORE_SPACE

# Not totally sure I need this
setopt HIST_VERIFY

# Incrementally write history to file
setopt INC_APPEND_HISTORY

# Save timestamp to history file too
setopt EXTENDED_HISTORY

# Import newly written commands from the history file
setopt SHARE_HISTORY

# Do not write duplicate event to history file
setopt HIST_SAVE_NO_DUPS

precmd() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history | tail -n 1)" >>! $HOME/history/zsh-history-$(date "+%Y-%m-%d").log;
    fi
}

# Use vi mode
bindkey -v

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Vi mode settings
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Vi-mode text object bindings
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Easier, more vim-like editor opening
# `v` is already mapped to visual mode, so we need to use a different key to
# open Vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^V" edit-command-line

# This just kills shell performance, I can't justify using it all the time for few the projects that need it
#eval "$(direnv hook zsh)"

# Run navi code so Ctrl-G in Zsh opens navi. There is likely a more efficient
# way of doing this.
eval "$(navi widget zsh)"

# Load theme
source $HOME/dotfiles/zsh/theme.zsh
