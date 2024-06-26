# Useful commands that I often forget

## Bash/Zshell Command Line

* `open out.svg; echo new-database.dot | entr sh -c 'dot new-database.dot -Tsvg -o out.svg; $HOME/dotfiles/reload-browser Firefox'` reload file in browser when it changes
* `open .` to open current directory in Finder
* `open -a TextEdit textfile.txt` to open a file in a specific application
* `echo "SMS notification" | sendmail -t '<phone number>@messaging.sprintpcs.com'` send an SMS notification by emailing the service's email to SMS gateway
* `dmesg` show startup log messages
* `stat -c%s` show file size
* `ln -s /dev/null ~/file/you/never/want/to/persist` good for ensure data written to the file by applications never persists
* `^X, ^E` to edit the currently typed command in vim
* `!!` run the last command again
* `command <<< "input text"` can be used in place of `command < file.in`
* `echo -n ✘ | hexdump` to print the encoding of a character by the console. Useful for bash scripts. Also use `od` to dump octals.
* `for f in directory/* ; do echo -e \\n\\n$f\\n 1>&1 ; cat $f ; done ;` print out all file name and file contents for all files in `directory`.
* `find ./ -type f -exec sed -i -e 's/foo/bar/g' {} \;` find and replace string in all files in a directory
* `find src -name 'old*' -type f -exec bash -c 'mv "$1" "${1/old/new}"' -- {} \;` rename every filename that matches pattern
* `sudo getent passwd | cut -d : -f 6 | sudo sed 's:$:/.bash_history:' | sudo xargs -d '\n' grep -H -e "$command"` or `grep -e "$pattern" /home/*/.bash_history` to see how others use a command
* `bindkey` show Zsh commands
* `cat *.c *.h | cpp -fpreprocessed | sed 's/[_a-zA-Z0-9][_a-zA-Z0-9]*/x/g' | tr -d ' \012' | wc -c` count words in C project
* `for ((n=0;n<10;n++)); do { time bundle exec rspec ./spec ; } 2>> time.txt; done` run a command ten times and write the execution time of each run to a file
* `xmllint --valid --encode utf-8 <file>; echo $?` validate that an XML file is valid and encoded as UTF-8
* `nmcli d wifi` show signals for wifi networks
* `nohup <long running command> &` leave a command running in the background. Even after logout.
* `reset` clears the terminal and resets the terminal state.
* `fc` open last command in `$EDITOR` for editing.

## Vim Commands

* `vit` select contents of html tag. `v`isual select text `i`n a `t`ag. `dit` would delete the contents of the tag.
* `^A` and `^X` allow you to increment the number your cursor is over, or first number after the cursor that is on the same line.
* `<F4>` toggles everything that occupies space to the left of the text (line numbers, gitgutter, etc...)
* `^F-[` in tmux works the same as `^F <PageUp>`, which puts tmux into scroll mode. This command comes in handy on keyboards that don't have `<PageUp>` and `<PageDown>`.
* `:21,25s/old/new/g` to substitute `new` for `old` on lines 21 through 25.
* When scrolling in tmux, `<fn> <UpArrow>` and `<fn> <DownArrow>` can be used instead of `<PageUp>` and `<PageDown>`. This also comes in handy on keyboards that lack Page Up and Page Down.
* `set list!` to toggle showing of whitespace characters.
* `g;` go back a change position
* `g,` go forward a change position
* `:'<,'>:w !<command>` pipe selection to STDIN of `<command>`. For example, to count the words selected run `:'<,'>:w !wc -w` or `:'<,'>:w !haste|pbcopy` to send to pastebin and copy the URL.
* `g^g` print number of selected lines when in visual mode
* `^x^l` complete whole line
* `cfdo s/foo/bar/g | update` - find and replace in all files in quickfix
* `:g/^\d/norm A;` - use g + norm to add a semicolon to every line that starts with a number.
* `e! ++enc=<encoding>` - reopen the file as a different encoding.
* `:r https://stratus3d.com/index.html` load remote file into buffer
* `:e https://stratus3d.com/index.html` load remote file into new buffer

## Make Targets and Commands

* `print-%: ; @echo $*=$($*)` or `print-%: ; @echo '$(subst ','\'',$*=$($*))'` allows you to run `make print-<variable_name>` and print the value of any variable. Can be used without modifying the file in GNU make 3.82 or greater like this: `make --eval="print-%: ; @echo $*=$($*)" print-SOURCE_FILES`.

## Gcc Flags

* `-ftrapv` trap signed integer overflows

## Erlang

* `erlang:system_info(port_limit).` show port/file limit
* `:inet.i()` show ports being used by processes in the VM

### Erlang Flags

* `bin_opt_info` print warnings and information about how binaries are used
* `+pc unicode` increase the range of characters that the system will consider printable. Helpful when testing with unicode in the shell

    :hackney_trace.enable(:max, :io)
