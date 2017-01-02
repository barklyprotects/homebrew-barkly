#!/bin/bash

BASEDIRFILE=$(dirname $0)
cd $BASEDIRFILE
BASEDIR=$(pwd -P)

if ! [ $BARKLYDIR ]; then
  echo Barkly directroy not defined.
  echo Please run from brew barkly instead.
  exit 1
fi

echo "Base setup."
echo "Starting brew installation..."
echo
brew bundle --file="$BASEDIR/Brewfile"
echo

echo "Cloning repos"
echo
while read REPO; do

  if ! [ -d "$BARKLYDIR/$REPO" ]; then
    echo ">> Cloning $REPO into $BARKLYDIR/$REPO"
    git clone https://github.com/barklyprotects/$REPO.git "$BARKLYDIR/$REPO"
  else
    echo ">> Skipping $REPO, already exists."
  fi
done < $BASEDIR/repos
