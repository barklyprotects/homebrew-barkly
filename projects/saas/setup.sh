#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

mkdir -p "$HOME/.env" &> /dev/null
for file in $THISDIR/files/env/*; do
  source $file
  cp "$file" "$HOME/.env"
done

npm install -g grunt-cli
