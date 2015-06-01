FILES="$HOME/dotfiles/mixings/general
$HOME/dotfiles/mixins/functions
$HOME/dotfiles/mixins/aliases
$HOME/dotfiles/mixins/grep
$HOME/dotfiles/mixins/nodejs
$HOME/dotfiles/mixins/path"

for file in $FILES
do
    [ -r $file ] && [ -f $file ] && source $file
done

export NVM_DIR="/Users/vadmin/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
