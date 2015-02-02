FILES="$HOME/.general
$HOME/.aliases
$HOME/.grep
$HOME/.nodejs
$HOME/.path"

for file in $FILES
do
    [ -r $file ] && [ -f $file ] && source $file
done
