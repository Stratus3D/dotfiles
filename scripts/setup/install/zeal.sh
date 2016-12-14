# Used these links to come up with this set of steps:
# https://github.com/zealdocs/zeal/wiki/Build-Instructions-for-OS-X
# http://mazhuang.org/2016/01/16/build-zeal-for-mac-osx/
# https://github.com/zealdocs/zeal/pull/372

# Deps
brew install qt5 libarchive
brew install qt5 qt5-qtwebengine qt5-sqlite-plugin libarchive

# Qt Creator
brew install Caskroom/cask/qt-creator
brew cask install qt-creator

# Download
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
cd bin

# Install
# This is what the blog post said to do, but it broke the app
#/usr/local/opt/qt5/bin/macdeployqt Zeal.app

# This works though
cp bin/Zeal.app /Applications

# Then alias
alias zeal='/Applications/Zeal.app/Contents/MacOS/Zeal'
