My Dotfiles
===========

**Stratus3D**

Everything I need to get setup on a new machine.

This repository contains my Vim, tmux, Zsh, Bash, and asdf config files, a script to symlink all the config files and directories in place, and a set of setup scripts that install all the tools I need on Ubuntu or OSX. The [Gruvbox Dark colorscheme](https://github.com/morhetz/gruvbox) is used for Vim and the terminal emulator profiles.

## Features

* Vim, tmux, Zsh, Bash, asdf, and Git configurations, as well as configurations for all other tools I use
* Setup script that symlinks dotfiles and installs all the software I use
* A collection of Bash scripts I rely on for software development
* Profiles for the terminal emulators I use
* [List of commands I often forget](docs/useful_commands.md)

## Installation

#### Prerequisites

* `curl` - For the command below

#### Installation Steps

1. Run the `setup.sh`. This will install all the necessary software, setup commonly used directories, and install dotfiles. Since the setup script is idempotent it can be run on machines that have already been setup without causing issues.

        curl -s https://raw.githubusercontent.com/Stratus3D/dotfiles/master/scripts/setup.sh --output setup.sh
        chmod +x setup.sh
        ./setup.sh | tee ~/setup.log

    On Debian this is all you need to do. Everything should be installed and configured correctly. On OSX there are two remaining steps.


2. (OSX only) Configure Terminal.app to use the custom profile stored in the dotfiles directory. In the Terminal preferences window under the Profiles tab click the "import" button and navigate to `~/dotfiles/terminal.app_profile/` and select the profile file.

## Configuration

Configurations for all the tools are need are checked into this repository. All the dotfiles are symlinked with to my home directory with the [scripts/makesymlinks.sh](scripts/makesymlinks.sh) script. The makesymlink.sh script is run by the setup.sh script, which is used to install these dotfiles.

## Software

This is software that I use for my day-to-day work. All of this is installed via the `setup.sh` script.

* [Git](https://git-scm.com/)
* [Vim](http://www.vim.org/)
* [Tmux](https://tmux.github.io/)
* [Z shell](http://zsh.sourceforge.net/)
* [asdf](https://github.com/asdf-vm/asdf)
* [Tmuxinator](https://github.com/tmuxinator/tmuxinator)
* [Exuberant Ctags](http://ctags.sourceforge.net/)
* [Dash/ZealDocs](http://zealdocs.org/)
* [Ungoogled Chromium](https://github.com/Eloston/ungoogled-chromium)

OSX Only

* [Hammerspoon](http://www.hammerspoon.org/)
* [Hammerspoon ShiftIt](https://github.com/peterklijn/hammerspoon-shiftit)

### Languages

Use asdf for version management ([https://github.com/asdf-vm/asdf](https://github.com/asdf-vm/asdf)) for each language.

* Erlang
* Elixir
* Ruby
* Python
* Lua
* Javascript (NodeJS)

## Documentation

Offline documentation suitable for day to day use.

* Erlang: [http://erldocs.com/](http://erldocs.com/)
* Elixir: [http://elixir-lang.org/docs.html](http://elixir-lang.org/docs.html)
* Ruby: [http://pjkh.com/articles/building-your-own-rails-and-ruby-searchable-api-docs/](http://pjkh.com/articles/building-your-own-rails-and-ruby-searchable-api-docs/) and [http://shynnergy.com/2012/02/create-local-ruby-on-rails-documentation-for-offline-use/](http://shynnergy.com/2012/02/create-local-ruby-on-rails-documentation-for-offline-use/)
* JavaScript: [https://developer.mozilla.org/media/developer.mozilla.org.tar.gz](https://developer.mozilla.org/media/developer.mozilla.org.tar.gz)
* C: [http://www.gnu.org/software/libc/manual/html_mono/libc.html](http://www.gnu.org/software/libc/manual/html_mono/libc.html)
* Make: [http://www.gnu.org/software/make/manual/make.html](http://www.gnu.org/software/make/manual/make.html)

## Repositories that I referred to when creating these dotfiles

* [Joshua Steele's dotfiles (https://github.com/joshukraine/dotfiles)](https://github.com/joshukraine/dotfiles)
* [thoughtbot/laptop (https://github.com/thoughtbot/laptop)](https://github.com/thoughtbot/laptop)
* [Michael J. Smalley's dotfiles (https://github.com/michaeljsmalley/dotfiles)](https://github.com/michaeljsmalley/dotfiles)
* [Gary Bernhardt's dotfiles (https://github.com/garybernhardt/dotfiles)](https://github.com/garybernhardt/dotfiles)
* [Andrew Stambrosky's dotfiles (https://github.com/astambrosky/dotfiles)](https://github.com/astambrosky/dotfiles)

## Feedback

Suggestions/improvements are welcome! Please [open an issue](https://github.com/Stratus3D/dotfiles/issues) or [contact me directly](https://stratus3d.com/contact).
