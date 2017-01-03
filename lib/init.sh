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
    repoArray=($REPO)
    repo="${repoArray[0]}"
    pull="${repoArray[1]}"

    if ! [ -d "$BARKLYDIR/$repo" ]; then
      echo ">> Cloning $repo into $BARKLYDIR/$repo"
      git clone https://github.com/barklyprotects/$repo.git "$BARKLYDIR/$repo"
    else
      echo ">> Skipping $repo, already exists."
      if [ -n "$pull" ] && [ "$pull"="pull" ]; then
        echo ">>> Pulling $repo"
        cd $BARKLYDIR/$repo && git pull
      fi
    fi
  done < $repos

}
