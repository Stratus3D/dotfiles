#!/usr/bin/env bash
#
# Install devdocs
#
# Usage ./devdocs.sh
#
# Had a hard time getting this installed. These questions helped some:
# * https://stackoverflow.com/questions/27699357/error-installing-eventmachine-gem-on-osx-yosemite
# * https://stackoverflow.com/questions/40038953/how-to-install-nokogiri-on-mac-os-sierra-10-12
#

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Install devdocs
# TODO: Decide where to install it.
cd $HOME/lib
git clone https://github.com/Thibaut/devdocs.git
cd devdocs
asdf install ruby 2.4.2
gem install bundler
# TODO: Fix issue with bundle install never finishing
bundle install

# Download all the docs
bundle exec thor docs:download --all
bundle exec rackup
