
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

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

DISABLE_CORRECTION="true"

source $ZSH/oh-my-zsh.sh

export ANDROID_HOME=/Users/tbrown/lib/adt-bundle-mac-x86_64-20131030

SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

export TERM="xterm-256color"
export EDITOR='vim'

source $HOME/.aliases
source $HOME/.grep
source $HOME/.path

export RBENV_ROOT="$HOME/.rbenv"
eval "$(rbenv init -)"

export MIRTH_MATCH_HOME=/opt/mirthmatch
export AS_HOME=/opt/glassfish
export AS_LOGS=/opt/glassfish/domains/domain1/logs
export AS_CFG=/opt/glassfish/domains/domain1/config
