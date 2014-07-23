My Dotfiles
===========

Stratus3D

My dotfiles. Everything I need to get setup on a new machine.

### Installation

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
Vim Commands
* `vit` select contents of html tag. `v`isual select text `i`n a `t`ag. `dit` would delete the contents of the tag.
* `^A` and `^X` allow you to increment the number your cursor is over, or first number after the cursor that is on the same line.
* `<F4>` toggles everything that occupies space to the left of the text (line numbers, gitgutter, etc...)

### Software
This is software that I need for my day-to-day programming work. I try to keep this list updated with the latest software I am using. This allows me to quickly setup new development machines.

#### Tools
* Git
* Vim
* Tmux
* Tmuxinator
* Chrome
* iTerm2 (Mac OSX)

#### Languages
* Erlang
  * Use kerl for installation of Erlang versions (https://github.com/cqwww/kerl)
  * Versions R16 and R17
* Elixir
  * Latest version (currently v0.14.0)
* Ruby
  * Use rbenv for management of Ruby versions (https://github.com/sstephenson/rbenv)
  * Use ruby-build for installation of Ruby versions (https://github.com/sstephenson/ruby-build)
  * Versions 1.9.\* and 2.1.\*
* Python
* Lua
* Javascript(NodeJS)
  * Use installer from (http://nodejs.org/)

#### Frameworks
* Rails
* AngularJS

###Misc Stuff
#####Colors

