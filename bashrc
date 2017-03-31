SOURCE="${BASH_SOURCE[0]}"

resolve_source() {
    SOURCE=$1;
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    echo $DIR
}

#resolve_source $SOURCE

FILES="$HOME/dotfiles/mixings/general
$HOME/dotfiles/mixins/asdf
$HOME/dotfiles/mixins/functions
$HOME/dotfiles/mixins/aliases
$HOME/dotfiles/mixins/grep
$HOME/dotfiles/mixins/path"


for file in $FILES
do
    [ -r $file ] && [ -f $file ] && source $file
done

# We need this so that tmux uses bash when started in a bash shell
export SHELL=/bin/bash

# Keep all history
shopt -s histappend
export HISTFILESIZE=
export HISTSIZE=
export HISTFILE=~/.bash_eternal_history
# Also write history to files in the history/ directory
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> $HOME/history/bash-history-$(date "+%Y-%m-%d").log; fi'
