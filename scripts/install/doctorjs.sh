#!/bin/bash -
#
# TODO: Complete this script

install_jsdoctor() {
    cd $HOME/lib
    git clone git@github.com:mozilla/doctorjs.git
    cd doctorjs
    make install
}

install_jsdoctor
