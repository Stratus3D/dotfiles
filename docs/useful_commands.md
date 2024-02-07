# Useful commands that I often forget

## Bash/Zshell Command Line

* `pcregrep --color='auto' -n '[^\x00-\x7F]' README.md` highlight lines in a file that contain non-ASCII characters. Alternatively use `grep` with the `-P` flag.
* `file -i file.txt` print encoding of file. On OSX use `file -I`.
* `echo "SMS notification" | sendmail -t '<phone number>@messaging.sprintpcs.com'` send an SMS notification by emailing the service's email to SMS gateway
* `stat -c%s` show file size
* `ln -s /dev/null ~/file/you/never/want/to/persist` good for ensure data written to the file by applications never persists
* `open .` to open current directory in Finder
* `open -a TextEdit textfile.txt` to open a file in a specific application
* `^X, ^E` to edit the currently typed command in vim
* `!!` run the last command again
* `cd -` change back to the previous directory
* `^A` move to the start of the line
* `^E` move to the end of the line
* `^B` move back one character
* `^P` scroll backward one item in history
* `^N` scroll forward obackne item in history
* `Esc-B` move back one word
* `Esc-F` move forward one word
* `^U` delete from cursor to the beginning of the line
* `^K` delete from the cursor to the end of the line
* `^Y` paste previously deleted command (separate from global Cmd-C buffer). Delete a line with `^A ^K` and then paste it back with `^Y`
* Files/directories can be dragged onto the terminal and the path will be pasted at the current cursor position
* `command <<< "input text"` can be used in place of `command < file.in`
* `echo -n ✘ | hexdump` to print the encoding of a character by the console. Useful for bash scripts. Also use `od` to dump octals.
* `for f in directory/* ; do echo -e \\n\\n$f\\n 1>&1 ; cat $f ; done ;` print out all file name and file contents for all files in `directory`.
* `iptables -vnL` show default firewall rules.
* `tcpdump -A` print out all packets.
* `tcpdump -i lo -s0 -w xyz.pcap` save all packets from interface to file.
* `export $(cut -d= -f1 <file>)` export all variables in file containing environment variables
* `unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)` unset all variables contained in an environment file
* `env $(cat .env | xargs) rails` run command with variables contained in environment file
* `env $(grep -v '^#' .env | xargs)` run command with variables contained in an environment file, ignore comments
* `find ./ -type f -exec sed -i -e 's/foo/bar/g' {} \;` find and replace string in all files in a directory
* `find src -name 'old*' -type f -exec bash -c 'mv "$1" "${1/old/new}"' -- {} \;` rename every filename that matches pattern
* `sudo getent passwd | cut -d : -f 6 | sudo sed 's:$:/.bash_history:' | sudo xargs -d '\n' grep -H -e "$command"` or `grep -e "$pattern" /home/*/.bash_history` to see how others use a command
* `bindkey` show Zsh commands
* `cat *.c *.h | cpp -fpreprocessed | sed 's/[_a-zA-Z0-9][_a-zA-Z0-9]*/x/g' | tr -d ' \012' | wc -c` count words in C project
* `file <img file>` show general image info like format and dimensions
* `identify -verbose <img file>` show colorspace, channel depth, dimensions, and other metadata for an image
* `for ((n=0;n<10;n++)); do { time bundle exec rspec ./spec ; } 2>> time.txt; done` run a command ten times and write the execution time of each run to a file
* `xmllint --valid --encode utf-8 <file>; echo $?` validate that an XML file is valid and encoded as UTF-8
* `nmcli d wifi` show signals for wifi networks
* `nohup <long running command> &` leave a command running in the background. Even after logout.
* `reset` clears the terminal and resets the terminal state.
* `fc` open last command in `$EDITOR` for editing.

## Vim Commands

* `vim -u NONE` start vim without any vimrc. `vim -u ~/.othervimrc` to specify a custom vimrc.
* `vit` select contents of html tag. `v`isual select text `i`n a `t`ag. `dit` would delete the contents of the tag.
* `^A` and `^X` allow you to increment the number your cursor is over, or first number after the cursor that is on the same line.
* `<F4>` toggles everything that occupies space to the left of the text (line numbers, gitgutter, etc...)
* `^F-[` in tmux works the same as `^F <PageUp>`, which puts tmux into scroll mode. This command comes in handy on keyboards that don't have `<PageUp>` and `<PageDown>`.
* `:21,25s/old/new/g` to substitute `new` for `old` on lines 21 through 25.
* When scrolling in tmux, `<fn> <UpArrow>` and `<fn> <DownArrow>` can be used instead of `<PageUp>` and `<PageDown>`. This also comes in handy on keyboards that lack Page Up and Page Down.
* `set list!` to toggle showing of whitespace characters.
* `g;` go back a change position
* `g,` go forward a change position
* `vim -V9logfile` tell Vim to log to file a named `logfile` in the current directory
* `:'<,'>:w !<command>` pipe selection to STDIN of `<command>`. For example, to count the words selected run `:'<,'>:w !wc -w` or `:'<,'>:w !haste|pbcopy` to send to pastebin and copy the URL.
* `g^g` print number of selected lines when in visual mode
* `^x^l` complete whole line
* `cfdo s/foo/bar/g | update` - find and replace in all files in quickfix
* `:g/^\d/norm A;` - use g + norm to add a semicolon to every line that starts with a number.
* `vim --startuptime timeCost.txt timeCost.txt` - record the startup time of vim.
* `e! ++enc=<encoding>` - reopen the file as a different encoding.
* `:r https://stratus3d.com/index.html` load remote file into buffer
* `:e https://stratus3d.com/index.html` load remote file into new buffer

## Make Targets and Commands

* `print-%: ; @echo $*=$($*)` or `print-%: ; @echo '$(subst ','\'',$*=$($*))'` allows you to run `make print-<variable_name>` and print the value of any variable. Can be used without modifying the file in GNU make 3.82 or greater like this: `make --eval="print-%: ; @echo $*=$($*)" print-SOURCE_FILES`.

## Screen Commands

* `^A d` detach current window.
* `screen -rd` to reattach a window. Follow the prompts if there are multiple windows.

## Gcc Flags

* `-ftrapv` trap signed integer overflows

## Erlang

* `erlang:system_info(port_limit).` show port/file limit
* `:inet.i()` show ports being used by processes in the VM

### Erlang Flags

* `bin_opt_info` print warnings and information about how binaries are used
* `+pc unicode` increase the range of characters that the system will consider printable. Helpful when testing with unicode in the shell

    :hackney_trace.enable(:max, :io)

## AWK and sed

* `#!/usr/bin/sed 1d .` - prints all but the first line of the sed file.

## Postgres

* `SHOW hba_file;` - Show the path to `pg_hba.conf` config file.
* `\du` - Show all roles
* `\x ON` - Turn extended display on in the psql console. This prints columns vertically, and is useful for when a table too wide to display in the console.
* `\df+ <function_name>` - Show the source code of a Postgres function.
