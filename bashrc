FILES="$HOME/.general
$HOME/.aliases
$HOME/.grep
$HOME/.nodejs
$HOME/.path"

for file in $FILES
do
    [ -r $file ] && [ -f $file ] && source $file
done

export NVM_DIR="/Users/vadmin/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
