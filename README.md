My Dotfiles
===========

**Stratus3D**

My dotfiles. Everything I need to get setup on a new machine.

### Installation
1. Run the `setup.sh`. This will install all the necessary software, setup commonly used directories, and install dotfiles. Since the setup script is idempotent it can be run on machines that have already been setup without causing issues.

       curl --remote-name https://raw.githubusercontent.com/Stratus3D/dotfiles/master/scripts/setup.sh
       sh setup.sh 2>&1 | tee ~/setup.log

    On Debian this is all you need to do. Everything should be installed and configured correctly. On OSX there are two remaining steps.


2. (OSX only) Configure iTerm2 to use the custom profile stored in the dotfiles directory. In the iTerm2 preferences window click the "browse" button and navigate to `~/dotfiles/iterm2_profile/` and select the plist file.
3. (OSX only) Load Better Touch Tool mappings that are stored in the dotfiles directory. Open Better Touch Tool and click the import button. Choose `~/dotfiles/better_touch_tool/better_touch_tool_configuration`.

### Issues
* Since these dotfiles are shared across my machines, there are scenarios where PATH will need to be different. PATH will need to be customized in `mixins/path`.

### TODO
* Complete the `clone_all_bitbucket_repos.sh` script so that all private repos can be cloned.
* Complete the `hosts_manager.sh` script.
* Allow for custom config files (`.bashrc`, `.zshrc`) and custom scripts.
* Figure out how to setup devdocs.io/zealdocs locally when running the setup script.
* Make all `source`s relative.
* Toggle syntastic icons at the beginning of the lines with F4.
* Integrate https://github.com/HashNuke/asdf for version management.
* Make vim highlight HTML and scripts in HTML correctly.
* Configure Bash and Zsh with infinite history.

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
* `^P` scroll backward one item in history
* `^N` scroll forward obackne item in history
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
* `ssh-add` allows identity to be used on remote machines by using the `-A` flag with the `ssh` command.
* `tar -cvzf tarballname.tar.gz file_or_directory` compresses `file_or_directory` to a tarball named `tarballname.tar.gz`.

OSX Commands
* `su` needs to be `sudo su`
* `| paste` needs to be `| paste -`

Vim Commands

* `vit` select contents of html tag. `v`isual select text `i`n a `t`ag. `dit` would delete the contents of the tag.
* `^A` and `^X` allow you to increment the number your cursor is over, or first number after the cursor that is on the same line.
* `<F4>` toggles everything that occupies space to the left of the text (line numbers, gitgutter, etc...)
* `^F-[` in tmux works the same as `^F <PageUp>`, which puts tmux into scroll mode. This command comes in handy on keyboards that don't have `<PageUp>` and `<PageDown>`.
* `:21,25s/old/new/g` to substitute `new` for `old` on lines 21 through 25.
* When scrolling in tmux, `<fn> <UpArrow>` and `<fn> <DownArrow>` can be used instead of `<PageUp>` and `<PageDown>`. This also comes in handy on keyboards that lack Page Up and Page Down.

SSH/SCP Commands

* `scp localfile user@remotehost:~` to copy `localfile` up to your home directory on `remotehost`.
* `scp user@remotehost:remote/file local/directory/` to download `file` from `remotehost`

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

Gcc Flags
* `-ftrapv` trap signed integer overflows

### Software
This is software that I need for my day-to-day programming work. I try to keep this list updated with the latest software I am using. This allows me to quickly setup new development machines. I am developing a script named checkenv.sh that will verify everything is setup properly.

#### Tools
* Git
* Vim
* Tmux
* Z shell ([http://zsh.sourceforge.net/](http://zsh.sourceforge.net/))
* oh-my-zsh ([https://github.com/robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh))
* Tmuxinator ([https://github.com/tmuxinator/tmuxinator](https://github.com/tmuxinator/tmuxinator))
* Exuberant Ctags ([http://ctags.sourceforge.net/](http://ctags.sourceforge.net/))
* iTerm2 (for Mac OSX)
* Mou [http://25.io/mou/](http://25.io/mou/) (for Mac OSX)
* ipmenulet (for Mac OSX)
* BetterTouchTool [http://www.bettertouchtool.net/](http://www.bettertouchtool.net/) (for Mac OSX)
* Virtual Box [https://www.virtualbox.org/](https://www.virtualbox.org/) & ievms ([https://github.com/xdissent/ievms])
* pgAdmin ([http://www.pgadmin.org/download/](http://www.pgadmin.org/download/))
* Dash/ZealDocs ([http://zealdocs.org/])(http://zealdocs.org/)

#### Browsers
* Chrome
* Firefox

#### Languages
* Erlang
  * Use asdf for version management (https://github.com/HashNuke/asdf)
  * Versions R16 and R17
* Elixir
  * Use asdf for version management (https://github.com/HashNuke/asdf)
  * Latest version (currently v0.14.0)
* Ruby
  * Use rbenv (https://github.com/sstephenson/rbenv) or asdf (https://github.com/HashNuke/asdf) for management of Ruby versions
  * Use ruby-build for installation of Ruby versions (https://github.com/sstephenson/ruby-build)
  * Versions 1.9.\* and 2.1.\*
* Python
* Lua
  * Use asdf for version management (https://github.com/HashNuke/asdf)
  * LuaRocks for package management (https://luarocks.org/)
* Javascript(NodeJS)
  * Use installer from (http://nodejs.org/)
* Go
  * Download from (https://golang.org)
  * gvm version management (https://github.com/moovweb/gvm)

#### Frameworks
* Rails
* Phoenix
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
