#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

npm install -g grunt-cli
