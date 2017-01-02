#!/bin/bash

BASEDIRFILE=$(dirname $0)
cd $BASEDIRFILE
BASEDIR=$(pwd -P)

echo "Base setup."
echo "Starting brew installation..."
brew bundle --file="$BASEDIR/Brewfile"
