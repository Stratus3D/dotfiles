# Useful commands that I often forget

## Bash/Zshell Command Line

* `open out.svg; echo new-database.dot | entr sh -c 'dot new-database.dot -Tsvg -o out.svg; $HOME/dotfiles/reload-browser Firefox'` reload file in browser when it changes
* `dmesg` show startup log messages
* `!!` run the last command again
* `find ./ -type f -exec sed -i '.bak' -e 's/foo/bar/g' {} \;` find and replace string in all files in a directory. Follow up with `find . -type f -name '*.bak' -delete` if necessary
* `sudo getent passwd | cut -d : -f 6 | sudo sed 's:$:/.bash_history:' | sudo xargs -d '\n' grep -H -e "$command"` or `grep -e "$pattern" /home/*/.bash_history` to see how others use a command
* `etop -node testnode@localhost -setcookie 123` - run etop to see top like info for a running Erlang node
* `paste -sd+ - | bc` sum values in lines https://stackoverflow.com/a/18141152/85360
* `reset` clears the terminal and resets the terminal state.
* `fc` open last command in `$EDITOR` for editing. (**f**ix **c**ommand)

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
* `^g` and `^t` - jump through matches while typing in a search

## Make Targets and Commands

* `print-%: ; @echo $*=$($*)` or `print-%: ; @echo '$(subst ','\'',$*=$($*))'` allows you to run `make print-<variable_name>` and print the value of any variable. Can be used without modifying the file in GNU make 3.82 or greater like this: `make --eval="print-%: ; @echo $*=$($*)" print-SOURCE_FILES`.

## Erlang

* `erlang:system_info(port_limit).` show port/file limit
* `:inet.i()` show ports being used by processes in the VM
* `:hackney_trace.enable(:max, :io)` enable tracing of Hackney requests
* `Ctrl+g i <ret> c <ret>` to stop code that is stuck running and blocking the shell
* `Ctrl+]` to auto-close open brackets

### Erlang Flags

* `bin_opt_info` print warnings and information about how binaries are used
* `+pc unicode` increase the range of characters that the system will consider printable. Helpful when testing with unicode in the shell
