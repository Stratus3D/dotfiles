FILES="~/.general ~/.aliases ~/.grep ~/.path"

for file in FILES
do
    [ -r $file ] && [ -f $file ] && source $file
done
