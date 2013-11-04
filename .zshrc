PATH=/usr/local/bin:/usr/local/sbin:$PATH # brew 
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting 

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
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

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$HOME/src:$PATH:/usr/local/bin:/usr/local/sbin:$HOME/.rvm/bin:/Users/user/.rvm/gems/ruby-1.9.3-p194/bin:/Users/user/.rvm/gems/ruby-1.9.3-p194@global/bin:/Users/user/.rvm/rubies/ruby-1.9.3-p194/bin:/Users/user/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/git/bin

PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

export TERM="xterm-256color"
export EDITOR='vim'

# source `which tmuxinator.zsh`

alias vim="/usr/local/bin/vim"

alias gs="git status"
alias gco="git commit "
alias gdh="git diff HEAD "

eval "$(rbenv init -)"
