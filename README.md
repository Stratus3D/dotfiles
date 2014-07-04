My Dotfiles
===========

Stratus3D

### Installation

    # download the files
    cd ~
    git clone https://github.com/Stratus3D/dotfiles.git
    cd dotfiles/

    # run the install script, which symlinks the dotfiles
    chmod +x makesymlinks.sh
    ./makesymlinks.sh

### Easily Forgottten Command Line Tricks
* `open .` to open current directory in Finder
* `python -m SimpleHTTPServer 8000` runs a webserver that serves the contents of the directory
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


### Issues

* Since these dotfiles are shared across my machines, there are scenarios where portions of the dotfiles will need to be altered. Such as the as the path variables in zshrc.
