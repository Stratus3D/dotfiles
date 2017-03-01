#!/usr/bin/env bash
#
# Build and install the zeal app on OSX. Places it in the /Applications directory
#
# Usage ./zeal.sh

# Used these links to come up with this set of steps:
#
# * https://github.com/zealdocs/zeal/wiki/Build-Instructions-for-OS-X
# * http://mazhuang.org/2016/01/16/build-zeal-for-mac-osx/
# * https://github.com/zealdocs/zeal/pull/372

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Deps
brew tap homebrew/versions
brew install qt5 libarchive
#brew install qt5 # qt5-qtwebengine qt5-sqlite-plugin libarchive

# Qt Creator
brew install Caskroom/cask/qt-creator
brew cask install qt-creator

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX") || exit 1
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

# Download zeal
git clone https://github.com/zealdocs/zeal.git
cd zeal

# Configure
# Add this to the pri file:
# Note that the versions in the paths must be correct.
cat << EOF >> src/libs/core/core.pri
macx: {
    INCLUDEPATH += /usr/local/Cellar/libarchive/3.2.2/include
    LIBS += -L/usr/local/Cellar/libarchive/3.2.2/lib -larchive
    INCLUDEPATH += /usr/local/Cellar/sqlite/3.15.2/include
    LIBS += -L/usr/local/Cellar/sqlite/3.15.2/lib -lsqlite3

}
EOF

# Build
# Not sure if INCLUDEPATH and LIBS really need to be set
/usr/local/opt/qt5/bin/qmake -makefile INCLUDEPATH+=/usr/local/opt/libarchive/include "LIBS+=-L/usr/local/opt/libarchive/lib -larchive"
make

# Install
# This is what the blog post said to do, but it broke the app
#/usr/local/opt/qt5/bin/macdeployqt Zeal.app
# This works though
cp -r bin/Zeal.app /Applications

# Remove temp directory
rm -rf $TEMP_DIR

cat <<EOF

Installation complete! You should see the Zeal app in your applications
directory. OSX will complain about the app being from an unidenfied developer,
so you need to tell it to allow Zeal.

For use on the command line add this to your .bashrc:

    alias zeal='/Applications/Zeal.app/Contents/MacOS/Zeal'

EOF
