My Dotfiles
===========

**Stratus3D**

My dotfiles. Everything I need to get setup on a new machine.

### Installation

####On a new machine
Run the `setup.sh`. This will install all the necessary software, setup commonly used directories, and install dotfiles.

    curl --remote-name https://raw.githubusercontent.com/Stratus3D/dotfiles/master/setup.sh
    sh setup.sh 2>&1 | tee ~/setup.log

####On an existing machine

    # download the files
    cd ~
    git clone https://github.com/Stratus3D/dotfiles.git
    cd dotfiles/

    # run the install script, which symlinks the dotfiles
    chmod +x makesymlinks.sh
    ./makesymlinks.sh


### Issues
* Since these dotfiles are shared across my machines, there are scenarios where portions of the dotfiles will need to be altered. Such as the as the path variables in zshrc.


### Easily Forgotten Command Line Tricks
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

Vim Commands
* `vit` select contents of html tag. `v`isual select text `i`n a `t`ag. `dit` would delete the contents of the tag.
* `^A` and `^X` allow you to increment the number your cursor is over, or first number after the cursor that is on the same line.
* `<F4>` toggles everything that occupies space to the left of the text (line numbers, gitgutter, etc...)
* `^F-[` in tmux works the same as `^F <PageUp>`, which puts tmux into scroll mode. This command comes in handy on keyboards that don't have `<PageUp>` and `<PageDown>`.
* `:21,25s/old/new/g` to substitute `new` for `old on lines 21 through 25.
* When scrolling in tmux, `<fn> <UpArrow>` and `<fn> <DownArrow>` can be used instead of `<PageUp>` and `<PageDown>`. This also comes in handy on keyboards that lack Page Up and Page Down.


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
* Mou (for Mac OSX)
* ipmenulet (for Mac OSX)
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

###Misc Stuff
#####Colors

###Repos that I referred to when creating this
* [Joshua Steele's dotfiles (https://github.com/joshukraine/dotfiles)](https://github.com/joshukraine/dotfiles)
* [thoughtbot/laptop (https://github.com/thoughtbot/laptop)](https://github.com/thoughtbot/laptop)
