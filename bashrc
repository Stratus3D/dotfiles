FILES="$HOME/.general
$HOME/.aliases
$HOME/.grep
$HOME/.path"

for file in $FILES
do
    [ -r $file ] && [ -f $file ] && source $file
done
