My Dotfiles
===========

**Stratus3D**

Everything I need to get setup on a new machine.

This repository contains my Vim, tmux, Zsh, Bash, and asdf config files, a script to symlink all the config files and directories in place, and a set of setup scripts that install all the tools I need on Ubuntu or OSX.

## Features

* Vim, tmux, Zsh, Bash, asdf, and Git configurations
* Setup script that symlinks dotfiles and installs all the software I use
* A collection of Bash scripts I rely on for Erlang development
* List of commands I often forget

## Installation

#### Prerequisites

* `curl` - For the command below

#### Installation Steps
1. Run the `setup.sh`. This will install all the necessary software, setup commonly used directories, and install dotfiles. Since the setup script is idempotent it can be run on machines that have already been setup without causing issues.

        curl -s https://raw.githubusercontent.com/Stratus3D/dotfiles/master/scripts/setup.sh | bash 2>&1 | tee ~/setup.log

    On Debian this is all you need to do. Everything should be installed and configured correctly. On OSX there are two remaining steps.


2. (OSX only) Configure iTerm2 to use the custom profile stored in the dotfiles directory. In the iTerm2 preferences window click the "browse" button and navigate to `~/dotfiles/iterm2_profile/` and select the plist file.

## Software

This is software that I need for my day-to-day programming work. I try to keep this list updated with the latest software I am using. This allows me to quickly setup new development machines. I am developing a script named checkenv.sh that will verify everything is setup properly.

### Tools

* Git ([https://git-scm.com/](https://git-scm.com/))
* Vim ([http://www.vim.org/](http://www.vim.org/))
* Tmux ([https://tmux.github.io/](https://tmux.github.io/))
* Z shell ([http://zsh.sourceforge.net/](http://zsh.sourceforge.net/))
* asdf ([https://github.com/asdf-vm/asdf](https://github.com/asdf-vm/asdf))
* oh-my-zsh ([https://github.com/robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh))
* Tmuxinator ([https://github.com/tmuxinator/tmuxinator](https://github.com/tmuxinator/tmuxinator))
* Exuberant Ctags ([http://ctags.sourceforge.net/](http://ctags.sourceforge.net/))
* Virtual Box ([https://www.virtualbox.org/](https://www.virtualbox.org/)) & ievms ([https://github.com/xdissent/ievms](https://github.com/xdissent/ievms))
* pgAdmin ([http://www.pgadmin.org/download/](http://www.pgadmin.org/download/))
* Dash/ZealDocs ([http://zealdocs.org/](http://zealdocs.org/))

OSX Only

* iTerm2 [https://iterm2.com/](https://iterm2.com/)
* Mou [http://25.io/mou/](http://25.io/mou/)
* ipmenulet [https://github.com/mcandre/IPMenulet](https://github.com/mcandre/IPMenulet)
* ShiftIt [https://github.com/fikovnik/ShiftIt](https://github.com/fikovnik/ShiftIt)

### Browsers

* Firefox
* Chrome

### Languages

Use asdf for version management ([https://github.com/HashNuke/asdf](https://github.com/HashNuke/asdf)) of each language unless otherwise noted.

* Erlang
* Elixir
* Ruby
* Python
* Lua
  * LuaRocks for package management ([https://luarocks.org/](https://luarocks.org/))
* Javascript(NodeJS)
* Go

### Frameworks
* [Rails](http://rubyonrails.org/)
* [Phoenix](http://www.phoenixframework.org/)
* [AngularJS](https://angularjs.org/)

##Documentation

Offline documentation suitable for day to day use.

* Erlang: [http://erldocs.com/](http://erldocs.com/)
* Elixir: [http://elixir-lang.org/docs.html](http://elixir-lang.org/docs.html)
* Ruby: [http://pjkh.com/articles/building-your-own-rails-and-ruby-searchable-api-docs/](http://pjkh.com/articles/building-your-own-rails-and-ruby-searchable-api-docs/) and [http://shynnergy.com/2012/02/create-local-ruby-on-rails-documentation-for-offline-use/](http://shynnergy.com/2012/02/create-local-ruby-on-rails-documentation-for-offline-use/)
* JavaScript: [https://developer.mozilla.org/media/developer.mozilla.org.tar.gz](https://developer.mozilla.org/media/developer.mozilla.org.tar.gz)
* Golang: Run `godoc -http=:6060` and then navigate to [http://localhost:6060/doc/](http://localhost:6060/doc/)
* C: [http://www.gnu.org/software/libc/manual/html_mono/libc.html](http://www.gnu.org/software/libc/manual/html_mono/libc.html)
* Make: [http://www.gnu.org/software/make/manual/make.html](http://www.gnu.org/software/make/manual/make.html)

##Color Schemes

* [Solarized Color Scheme (http://ethanschoonover.com/solarized)](http://ethanschoonover.com/solarized)

##Repos that I referred to when creating these dotfiles

* [Joshua Steele's dotfiles (https://github.com/joshukraine/dotfiles)](https://github.com/joshukraine/dotfiles)
* [thoughtbot/laptop (https://github.com/thoughtbot/laptop)](https://github.com/thoughtbot/laptop)
* [Michael J. Smalley's dotfiles (https://github.com/michaeljsmalley/dotfiles)](https://github.com/michaeljsmalley/dotfiles)
* [Gary Bernhardt's dotfiles (https://github.com/garybernhardt/dotfiles)](https://github.com/garybernhardt/dotfiles)
* [Andrew Stambrosky's dotfiles (https://github.com/astambrosky/dotfiles)](https://github.com/astambrosky/dotfiles)

## TODO

* Complete the `clone_all_bitbucket_repos.sh` script so that all private repos can be cloned.
* Complete the `hosts_manager.sh` script.
* Figure out how to setup docsets locally when running the setup script.
* Make vim highlight HTML and scripts in HTML correctly.
* Add solarized light/dark toggle functions.
* Make vim read color scheme from zsh.

##Useful commands that I often forget

Bash/Zshell Commands

* `open .` to open current directory in Finder
* `open -a TextEdit textfile.txt` to open a file in a specific application
* `python -m SimpleHTTPServer 8000` runs a webserver that serves the contents of the directory
* `python -m smtpd -n -c DebuggingServer localhost:25` runs a SMTP server that logs all messages to the console
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
* `pkill <process_name>` kills all processes with the given name (e.g. `pkill HipChat` kills the HipChat app). The `-u` flag limits the killing to all processes with a certain euid (e.g. `pkill -u username HipChat`)
* `kill <process_id>` kills the process identified by `<process_id>`. `-9` can be used to kill the process immediately
* `echo -n ✘ | hexdump` to print the encoding of a character by the console. Useful for bash scripts
* `for f in directory/* ; do echo -e \\n\\n$f\\n 1>&1 ; cat $f ; done ;` print out all file name and file contents for all files in `directory`.
* `ssh -vT git@github.com` useful for debugging SSH authentication issues.
* `sudo -u git -H ssh -vT bitbucket.org` similar to the SSH command above, only test the connection for a specific user.
* `ssh-add` allows identity to be used on remote machines by using the `-A` flag with the `ssh` command.
* `tar -cvzf tarballname.tar.gz file_or_directory` compresses `file_or_directory` to a tarball named `tarballname.tar.gz`.
* `ssh -A -L 5432:localhost:5432 remoteserver` to proxy whatever (e.g. PostgreSQL) is listening on port `5432` on `remoteserver` to port 5432 on `localhost`.
* `ss -tunapl` show which processes are running on which ports.
* `ss -lntu` show which ports have listeners.
* `ls -i -P` show which processes are running on which ports.
* `iptables -vnL` show default firewall rules.
* `tcpdump -A` print out all packets.
* `tcpdump -i lo -s0 -w xyz.pcap` save all packets from interface to file.
* `export $(cut -d= -f1 <file>)` export all variables in file containing environment variables
* `find ./ -type f -exec sed -i -e 's/foo/bar/g' {} \;` find and replace string in all files in a directory
* `find src -name 'old*' -type f -exec bash -c 'mv "$1" "${1/old/new}"' -- {} \;` rename every filename that matches pattern
* `sudo getent passwd | cut -d : -f 6 | sudo sed 's:$:/.bash_history:' | sudo xargs -d '\n' grep -H -e "$command"` or `grep -e "$pattern" /home/*/.bash_history` to see how others use a command
* `bindkey` show Zsh commands
* `cat *.c *.h | cpp -fpreprocessed | sed 's/[_a-zA-Z0-9][_a-zA-Z0-9]*/x/g' | tr -d ' \012' | wc -c` count words in C project
* `column -t -s ',' data.csv` print CSV as a table in the terminal

OSX Commands
* `su` needs to be `sudo su`
* `| paste` needs to be `| paste -`
* `lsvfs` get details on file systems
* `killall -STOP AppName` pause an app
* `killall -CONT AppName` resume an app

Vim Commands

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
* `:'<,'>:w !<command>` pipe selection to STDIN of `<command>`. For example, to count the words selected run `:'<,'>:w !wc -w`.
* `g^g` print number of selected lines when in visual mode

SSH/SCP Commands

* `scp localfile user@remotehost:~` to copy `localfile` up to your home directory on `remotehost`.
* `scp user@remotehost:remote/file local/directory/` to download `file` from `remotehost`

Make Targets and Commands

* `print-%: ; @echo $*=$($*)` or `print-%: ; @echo '$(subst ','\'',$*=$($*))'` allows you to run `make print-<variable_name>` and print the value of any variable. Can be used without modifying the file in GNU make 3.82 or greater like this: `make --eval="print-%: ; @echo $*=$($*)" print-SOURCE_FILES`.

Screen Commands

* `^A d` detach current window.
* `screen -rd` to reattach a window. Follow the prompts if there are multiple windows.

Git Commands

* `git clean -X` - Remove files ignored by Git
* `git checkout $(git rev-list -n 1 --before="2016-07-05 21:00" master)` - Checkout a branch at a specific point in time.
* `git show $(git rev-list -n 1 --before="2016-07-05 21:00" master):path/to/file` - Show what a file looked like at a specific point in time on a specific branch.
* `--ignore-all-space` - Ignore whitespace only changes when showing diff.
* `git stash save --keep-index` - Stash everything except what is already staged.
* `git add -p` - Stage specific changes in a file.
* `git merge-base --is-ancestor <commit-1> <commit-2>` - Check if `commit-1` is an ancestor of `commit-2`.
* `git describe --long` - version string suitable for Erlang module `-vsn` attributes.
* `git log --grep="^prefix" --pretty='format:%h - %cn - %s'` find all commits with `prefix`
* `git log -p --cc` show only resolved conflicts in merge commits
* `git shortlog -sn --since='10 weeks' --until='2 weeks'` show number commits by each committer between two times
* `git diff --word-diff` show changed words rather than lines

Irssi Commands

* `/server`
* `/connect <server name>` - Connect to an IRC server (`/connect irc.freenode.net`)
* `/join <channel name>` - Join a channel on an IRC server (`/join #erlang`)
* `/disconnect`
* `/q <users nick>`  starts a private message with a user.
* `/wc` closes the current window. This parts from the current channel or disconnects from the current network.
* `Alt + Left Arrow/Right Arrow` scroll through Irssi windows.

VirtualBox Commands

* `VBoxManage unregistervm --delete <vm name>` Completely removes the VM and all associated files

Gcc Flags

* `-ftrapv` trap signed integer overflows

Erlang Flags

* `bin_opt_info` print warnings and information about how binaries are used
* `+pc unicode` increase the range of characters that the system will consider printable. Helpful when testing with unicode in the shell

Bash Flags

* `set -x` - Turn on debug mode.
* `set -e` - Exit if any command has a non-zero exit status. This ensures all commands that can fail are handled properly.
* `set -u` - Exit if any variable is undefined (other than $* and $@, which are assumed to be available).
* `set -o pipefail` - Causes any non-zero exit status in a pipeline to be the exit status of the entire pipeline.
http://redsymbol.net/articles/unofficial-bash-strict-mode/

Curl Commands

* `-w "%{http_code}\n"` - Show the status code of the response.

AWK and sed

* `#!/usr/bin/sed 1d .` - prints all but the first line of the sed file.

Postgres

* `SHOW hba_file;` - Show the path to `pg_hba.conf` config file.
* `\du` - Show all roles
* `\x ON` - Turn extended display on in the psql console. This prints columns vertically, and is useful for when a table too wide to display in the console.
* `\df+ <function_name>` - Show the source code of a Postgres function.

Pranks

* `say -v whisper "I am watching you"`
