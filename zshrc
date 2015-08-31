# Zshrc file
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator # For tmuxinator

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks" #"robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
plugins=(git)

DISABLE_CORRECTION="true"

# For my dotfiles repo to work correctly the paths to source'd files must be
# relative to the location of this file. This doesn't handle cases where the
# .zshrc is symlinked to a symlink.
# Taken from http://stackoverflow.com/a/26492107/1245380
ZSHRC_PATH=$(dirname "$(readlink "${(%):-%N}")")

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export ANDROID_HOME=$HOME/lib/adt-bundle-mac-x86_64-20131030

SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

# xterm-256color is the only profile that works in GNOME terminal
#export TERM="screen-256color"
export TERM="xterm-256color"

source $ZSHRC_PATH/mixins/general
source $ZSHRC_PATH/mixins/functions
source $ZSHRC_PATH/mixins/grep
source $ZSHRC_PATH/mixins/nodejs
source $ZSHRC_PATH/mixins/path

export MIRTH_MATCH_HOME=/opt/mirthmatch
export AS_HOME=/opt/glassfish
export AS_LOGS=/opt/glassfish/domains/domain1/logs
export AS_CFG=/opt/glassfish/domains/domain1/config

# export MANPATH="/usr/local/man:$MANPATH"
source $ZSH/oh-my-zsh.sh

source $ZSHRC_PATH/mixins/aliases

unalias gm # This alias has the same name as the GraphicsMagick binary
