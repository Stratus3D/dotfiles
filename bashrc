FILES="~/.aliases ~/.grep ~/.path"

for file in ~/.aliases ~/.grep ~/.path
do
    [ -r $file ] && [ -f $file ] && source $file
done
