FILES="$HOME/dotfiles/mixings/general
$HOME/dotfiles/mixings/aliases
$HOME/dotfiles/mixings/grep
$HOME/dotfiles/mixings/nodejs
$HOME/dotfiles/mixings/path"

for file in $FILES
do
    [ -r $file ] && [ -f $file ] && source $file
done

export NVM_DIR="/Users/vadmin/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
