PATH=~/.rbenv/shims:/usr/local/bin:/usr/local/sbin:$PATH # brew

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

# Customize to your needs...
export PATH=/usr/local/share/npm/bin:$HOME/.kerl/builds/R16B03-1/release_R16B03-1/bin:$HOME/lib/elixir/bin:$HOME/lib/luarocks-2.1.1\ Copy/src/bin:$HOME/lib/apache-ant-1.9.3/bin:$ANDROID_HOME/sdk/platform-tools:$ANDROID_HOME/sdk/tools:$HOME/lib/adt-bundle-mac-x86_64-20131030/sdk/platform-tools:/Applications/CoronaSDK:$HOME/lib/lua-5.1.5/src:$HOME/lib/neo4j-community-2.0.0-RC1/bin:$HOME/lib:/usr/local/bin:$PATH:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/git/bin

PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"

SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

export TERM="xterm-256color"
export EDITOR='vim'

alias vim="vi"

alias g="git"
alias gst="git status"
alias gco="git commit "
alias gdh="git diff HEAD "
alias glp="git log --graph --decorate --pretty=oneline --abbrev-commit --all"

export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
PATH=$JAVA_HOME/bin:$PATH
export MIRTH_MATCH_HOME=/opt/mirthmatch
export AS_HOME=/opt/glassfish
export AS_LOGS=/opt/glassfish/domains/domain1/logs
export AS_CFG=/opt/glassfish/domains/domain1/config
