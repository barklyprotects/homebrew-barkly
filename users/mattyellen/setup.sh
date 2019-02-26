#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
#. "$HOMEBREWBARKLYDIR/lib/init.sh"

cp -r vim ~/.vim
cp vimrc ~/.vimrc
