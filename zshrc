# My zsh configuration is designed to be as lean as possible while still giving
# me all the features I need, like autocomplete and git integration.
#
# Commands helpful when building zsh config
#
# * bindkey -l - List all keymaps available
# * bindkey -M <keymap> - Show all bindings in a keymap
# * zle -al - list all commands that can be bound
# * setopt - show zsh options that are set
# * set -o - list of all options that can be set
# * zstyle - show configured styles
# * compinstall - configuration completions
#
# Helpful widgets
#
# * where-is - show what keystrokes a particular widget is bound to
# * describe-key-briefly - show escape sequence for keystroke
#
# References
#
# * https://ohmyz.sh/
# * https://zsh.sourceforge.io/Doc/zsh_us.pdf
# * https://thevaluable.dev/zsh-install-configure-mouseless/
# * https://thevaluable.dev/zsh-line-editor-configuration-mouseless/
# * https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
# * https://zsh.sourceforge.io/Doc/Release/Options.html#Option-Aliases
# * https://thevaluable.dev/zsh-completion-guide-examples/
# * https://github.com/Phantas0s/.dotfiles/blob/master/zsh/zshrc

# GENERAL
# ----------

# We need this so that tmux uses zsh when started in a zsh shell
export SHELL='/bin/zsh'

# Print jobs in long format
setopt LONG_LIST_JOBS

# Allow comments in interactive shells
setopt INTERACTIVE_COMMENTS

# Enable implicit redirection to multiple streams: echo >file1 >file2
setopt MULTIOS

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

# HISTORY
# ----------

# Default location for history file
HISTFILE=$HOME/.zsh_history

# There is no way to define history size as infinite so we set it to 1 billion
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

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

# Do not write duplicate event to history file
setopt HIST_SAVE_NO_DUPS

# Note to self: use fc -RI to import commands from other zsh sessions

precmd() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history | tail -n 1)" >>! $HOME/history/zsh-history-$(date "+%Y-%m-%d").log;
    fi
}

# PLUGINS
# ----------

# Load antigen
source $HOME/.antigen/antigen.zsh

# Non-standard completions
antigen bundle zsh-users/zsh-completions

# zsh syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done
antigen apply

# COMPLETION
# ----------

# Not sure if I want to keep these settings
setopt ALWAYS_TO_END
setopt COMBINING_CHARS

# Complete from both ends of a word
setopt COMPLETE_IN_WORD

# Don't require a leading . to match hidden files
setopt GLOB_DOTS

# This is faster than `autoload -U compinit && compinit`
autoload -Uz compinit

# Should be called before compinit
zmodload -i zsh/complist

if command -v brew 2>&1 >/dev/null; then
  # Load completions from brew-installed programs https://docs.brew.sh/Shell-Completion
  eval "$(brew shellenv)"
fi

# Manually add completion for asdf
# Run `mkdir -p $HOME asdf; asdf completion zsh > $HOME/.zsh-completions/asdf.bash`
fpath=($HOME/.zsh-completions/ $fpath)

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

# KEY BINDINGS
# ----------

# Use vi mode
bindkey -v

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Vi mode settings
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys in insert mode or k/j command mode
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Completion menu bindings
# Use hjlk in menu selection (during completion)
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Undo suggestion selection
bindkey -M menuselect '^xu' undo

# Maintain traditional incremental search behavior
bindkey '^r' history-incremental-search-backward

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

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# decarg isn't going to work until the next version of Zsh is tagged (current
# is 5.9.0) but I'm adding it now because I think this will be something I will
# use.
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/incarg
autoload -Uz incarg

for widget in vim-{,sync-}{inc,dec}arg; do
  zle -N "$widget" incarg
done

bindkey -a \
  '^A' vim-incarg \
  '^X' vim-decarg \
  'g^A' vim-sync-incarg \
  'g^X' vim-sync-decarg

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# STYLING/COMPLETION STYLING
# ----------

# From the documentation for zstyle:
#
# > The fields are always in the order :completion:function:completer:command:argument:tag.

# Match spec to fall back to case-insensitive when no case-sensitive matches found
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Group each type  of completion match into its own group
zstyle ':completion:*' group-name ''

# Sort files by modification date, unsure if I like this sort
zstyle ':completion:*' file-sort modification

# Use caching so that slow commands are useable
zstyle ':completion:*' use-cache yes

# Show more verbose suggestion output
zstyle ':completion:*' verbose yes

# Suggest the aliases like regular commands
zstyle ':completion:*' complete true

# Display a completion menu when any tags are available for the current completion
zstyle ':completion:*' menu select

# Use file and directory colors from those specified for GNU ls
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Special format for warning when no results found
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

# Colorize process suggestions for commands that operate on processes
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# The command to use to populate the list of processes
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# Hostname completion from ssh known hosts
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Suggest directories more likely to be `cd` to first
zstyle ':completion:*:*:cd:*' tag-order directory-stack local-directories path-directories

# Define a specific ordering for command suggestion groups
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# Completers to be used. I like to be able to expand aliases if I want
zstyle ':completion:*' completer _expand_alias _extensions _complete _approximate

# CUSTOM ZLE WIDGETS
# -----------------

# Custom accept-line widget displays confirmation prompt if the command contains
# the substring 'prod'. This is useful to prevent accidental execution of
# commands against prod
#
# An improvement on
# https://medium.com/the-cloud-corner/cancel-a-terminal-command-during-preexec-zsh-function-c5b0d27b99fb
 function confirm_potential_prod_command() {
  if [[ "$BUFFER" =~ 'prod' ]]; then
    printf "\n$(tput setab 1)$(tput setaf 7)Are you sure you want to run '%s'? [y/N]:$(tput sgr0)" "$BUFFER"
    local reply
    read -k 1 reply < /dev/tty
    reply="${reply//[[:space:]]/}"   # Remove ALL whitespace
    reply="${reply:l}"               # Convert to lowercase (Zsh feature)
    if [[ "$reply" != "y" ]]; then
      printf '\nDid not run "%s".' "$BUFFER"
      zle -I
      BUFFER=""
      return 1
    fi
  fi
  # Call the built-in accept-line
  zle .accept-line
}

zle -N accept-line confirm_potential_prod_command

# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
# See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
# https://unix.stackexchange.com/questions/433273/changing-cursor-style-based-on-mode-in-both-zsh-and-vim
cursor_block='\e[2 q'
cursor_beam='\e[5 q'

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
        echo -ne $cursor_block
    elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
        echo -ne $cursor_beam
    fi
}

zle-line-init() {
    echo -ne $cursor_beam
}

zle -N zle-keymap-select
zle -N zle-line-init

# THEME & GIT
# ----------

DOTFILES_DIR=$HOME/dotfiles

# Theme uses git functions
source $DOTFILES_DIR/zsh/git.zsh

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Load theme
source $HOME/dotfiles/zsh/theme.zsh

# SCRIPTS & CUSTOM
# ----------

source $DOTFILES_DIR/mixins/general
source $DOTFILES_DIR/mixins/functions
source $DOTFILES_DIR/mixins/grep
source $DOTFILES_DIR/mixins/asdf
source $DOTFILES_DIR/mixins/path
source $DOTFILES_DIR/mixins/aliases

# Run navi code so Ctrl-G in Zsh opens navi. There is likely a more efficient
# way of doing this.
eval "$(navi widget zsh)"

# fzf integrations
# https://github.com/junegunn/fzf?tab=readme-ov-file#fuzzy-completion-for-bash-and-zsh
# https://pragmaticpineapple.com/four-useful-fzf-tricks-for-your-terminal/
source <(fzf --zsh)
# Hack to get the Alt-C binding working on MacOS
bindkey "ç" fzf-cd-widget

# Custom options
if [ -f "$HOME/dotfiles/mixins/shellrc.custom" ]; then
    source "$HOME/dotfiles/mixins/shellrc.custom"
fi
