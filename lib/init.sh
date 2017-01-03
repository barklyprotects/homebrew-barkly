#!/bin/bash
# Library of functions for use in project files

check_init() {
  if ! [ $BARKLYDIR ]; then
    echo Barkly directroy not defined.
    echo Please run from brew barkly instead.
    exit 1
  fi
}

clonerepos() {
  repos=$1
  while read REPO; do
    if ! [ -d "$BARKLYDIR/$REPO" ]; then
      echo ">> Cloning $REPO into $BARKLYDIR/$REPO"
      git clone https://github.com/barklyprotects/$REPO.git "$BARKLYDIR/$REPO"
    else
      echo ">> Skipping $REPO, already exists."
    fi
  done < $repos

}
