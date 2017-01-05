#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

# Start your script below and user any helpsers setup in lib/init.sh
cd $BARKLYDIR/cuckoo-osx-env
git submodule init && git submodule update
