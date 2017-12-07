#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

# Start your script below and user any helpsers setup in lib/init.sh
npm install -g grunt-cli

mkdir -p "$HOME/.env" &> /dev/null
for file in $THISDIR/files/env/*; do
  source $file
  cp "$file" "$HOME/.env"
done

conda create -n rml-datamart python=3.6.1 -y
