My Dotfiles
===========

**Stratus3D**

My dotfiles. Everything I need to get setup on a new machine.

### Installation
Run the `setup.sh`. This will install all the necessary software, setup commonly used directories, and install dotfiles.

    curl --remote-name https://raw.githubusercontent.com/Stratus3D/dotfiles/master/scripts/setup.sh
    sh setup.sh 2>&1 | tee ~/setup.log

### Issues
* Since these dotfiles are shared across my machines, there are scenarios where PATH will need to be different. PATH will need to be customized in `path`.

### TODO
* Complete the setup script so it installs all software and configures iterm2 with my custom profile.
* Complete the `clone_all_bitbucket_repos.sh` script so that all private repos can be cloned.
* Complete the `erlang_manager.sh` and `hosts_manager.sh` scripts.
* Allow for custom config files (`.bashrc`, `.zshrc`, `.gitconfig`) and custom scripts.
* Figure out how to setup devdocs.io/zealdocs locally when running the setup script.
* Make all `source`s relative.
* Toggle syntastic icons at the beginning of the lines with F4.

###Useful commands that I often forget
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
* `Esc-B` move back one word
* `Esc-F` move forward one word
* `^U` delete from cursor to the beginning of the line
* `^K` delete from the cursor to the end of the line
* `^Y` paste previously deleted command (separate from global Cmd-C buffer). Delete a line with `^A ^K` and then paste it back with `^Y`
* Files/directories can be dragged onto the terminal and the path will be pasted at the current cursor position
* `command <<< "input text"` can be used in place of `command < file.in`
* `pkill <process_name>` kills all processes with the given name (e.g. `pkill HipChat` kills the HipChat app)
* `kill <process_id>` kills the process identified by `<process_id>`. `-9` can be used to kill the process immediately
* `echo -n ✘ | hexdump` to print the encoding of a character by the console. Useful for bash scripts
* `ssh -vT git@github.com` useful for debugging SSH authentication issues.

Vim Commands

* `vit` select contents of html tag. `v`isual select text `i`n a `t`ag. `dit` would delete the contents of the tag.
* `^A` and `^X` allow you to increment the number your cursor is over, or first number after the cursor that is on the same line.
* `<F4>` toggles everything that occupies space to the left of the text (line numbers, gitgutter, etc...)
* `^F-[` in tmux works the same as `^F <PageUp>`, which puts tmux into scroll mode. This command comes in handy on keyboards that don't have `<PageUp>` and `<PageDown>`.
* `:21,25s/old/new/g` to substitute `new` for `old on lines 21 through 25.
* When scrolling in tmux, `<fn> <UpArrow>` and `<fn> <DownArrow>` can be used instead of `<PageUp>` and `<PageDown>`. This also comes in handy on keyboards that lack Page Up and Page Down.

SSH/SCP Commands

* `scp localfile user@remotehost:~` to copy `localfile` up to your home directory on `remotehost`.

Make Targets and Commands

* `print-%: ; @echo $*=$($*)` or `print-%: ; @echo '$(subst ','\'',$*=$($*))'` allows you to run `make print-<variable_name>` and print the value of any variable. Can be used without modifying the file in GNU make 3.82 or greater like this: `make --eval="print-%: ; @echo $*=$($*)" print-SOURCE_FILES`.

Screen Commands

* `^A d` detach current window.
* `screen -rd` to reattach a window. Follow the prompts if there are multiple windows.

Irssi Commands

* `/server`
* `/connect <server name>` - Connect to an IRC server (`/connect irc.freenode.net`)
* `/join <channel name>` - Join a channel on an IRC server (`/join #erlang`)
* `/disconnect`
* `/q <users nick>`  starts a private message with a user.
* `/wc` closes the current window. This parts from the current channel or disconnects from the current network.
* `Alt + Left Arrow/Right Arrow` scroll through Irssi windows.

### Software
This is software that I need for my day-to-day programming work. I try to keep this list updated with the latest software I am using. This allows me to quickly setup new development machines. I am developing a script named checkenv.sh that will verify everything is setup properly.

#### Tools
* Git
* Vim
* Z shell ([http://zsh.sourceforge.net/](http://zsh.sourceforge.net/))
* oh-my-zsh ([https://github.com/robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh))
* Tmux
* Tmuxinator ([https://github.com/tmuxinator/tmuxinator](https://github.com/tmuxinator/tmuxinator))
* Exuberant Ctags ([http://ctags.sourceforge.net/](http://ctags.sourceforge.net/))
* iTerm2 (for Mac OSX)
* Mou [http://25.io/mou/](http://25.io/mou/) (for Mac OSX)
* ipmenulet (for Mac OSX)
* BetterTouchTool [http://www.bettertouchtool.net/](http://www.bettertouchtool.net/) (for Mac OSX)
* Virtual Box [https://www.virtualbox.org/](https://www.virtualbox.org/) & ievms ([https://github.com/xdissent/ievms])
* pgAdmin ([http://www.pgadmin.org/download/](http://www.pgadmin.org/download/))

#### Browsers
* Chrome
* Firefox

#### Languages
* Erlang
  * Use kerl for installation of Erlang versions (https://github.com/cqwww/kerl)
  * Versions R16 and R17
* Elixir
  * Latest version (currently v0.14.0)
  * Use exenv for version management (https://github.com/mururu/exenv)
  * Use elixir-build for installation (https://github.com/mururu/elixir-build)
* Ruby
  * Use rbenv for management of Ruby versions (https://github.com/sstephenson/rbenv)
  * Use ruby-build for installation of Ruby versions (https://github.com/sstephenson/ruby-build)
  * Versions 1.9.\* and 2.1.\*
* Python
* Lua
  * LuaRocks for package management (https://luarocks.org/)
* Javascript(NodeJS)
  * Use installer from (http://nodejs.org/)
* Go
  * Download from (https://golang.org)
  * gvm version management (https://github.com/moovweb/gvm)

#### Frameworks
* Rails
* AngularJS

###Documentation
Offline documentation suitable for day to day use.
* Erlang: [http://erldocs.com/](http://erldocs.com/)
* Elixir: [http://elixir-lang.org/docs.html](http://elixir-lang.org/docs.html)
* Ruby: [http://pjkh.com/articles/building-your-own-rails-and-ruby-searchable-api-docs/](http://pjkh.com/articles/building-your-own-rails-and-ruby-searchable-api-docs/) and [http://shynnergy.com/2012/02/create-local-ruby-on-rails-documentation-for-offline-use/](http://shynnergy.com/2012/02/create-local-ruby-on-rails-documentation-for-offline-use/)
* JavaScript: [https://developer.mozilla.org/media/developer.mozilla.org.tar.gz](https://developer.mozilla.org/media/developer.mozilla.org.tar.gz)
* Golang: Run `godoc -http=:6060` and then navigate to [http://localhost:6060/doc/](http://localhost:6060/doc/)
* C: [http://www.gnu.org/software/libc/manual/html_mono/libc.html](http://www.gnu.org/software/libc/manual/html_mono/libc.html)
* Make: [http://www.gnu.org/software/make/manual/make.html](http://www.gnu.org/software/make/manual/make.html)

###Color Schemes
* [Solarized Color Scheme (http://ethanschoonover.com/solarized)](http://ethanschoonover.com/solarized)

###Repos that I referred to when creating these dotfiles
* [Joshua Steele's dotfiles (https://github.com/joshukraine/dotfiles)](https://github.com/joshukraine/dotfiles)
* [thoughtbot/laptop (https://github.com/thoughtbot/laptop)](https://github.com/thoughtbot/laptop)
* [Michael J. Smalley's dotfiles (https://github.com/michaeljsmalley/dotfiles)](https://github.com/michaeljsmalley/dotfiles)
* [Gary Bernhardt's dotfiles (https://github.com/garybernhardt/dotfiles)](https://github.com/garybernhardt/dotfiles)
* [Andrew Stambrosky's dotfiles (https://github.com/astambrosky/dotfiles)](https://github.com/astambrosky/dotfiles)
