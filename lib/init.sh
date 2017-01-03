#!/bin/bash
# Library of functions for use in project files

abort() { STRAP_STEP="";   echo "!!! $*" >&2; exit 1; }
log()   { STRAP_STEP="$*"; echo "--> $*"; }
logn()  { STRAP_STEP="$*"; printf -- "--> %s " "$*"; }
logk()  { STRAP_STEP="";   echo "OK"; }

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
    # Skip comments and empty lines
    [[ $REPO == \#* ]] || [ -z "$REPO" ] && continue

    repoArray=($REPO)
    repo="${repoArray[0]}"
    pull="${repoArray[1]}"

    if ! [ -d "$BARKLYDIR/$repo" ]; then
      logn "Cloning $repo into $BARKLYDIR/$repo:"
      git clone https://github.com/barklyprotects/$repo.git "$BARKLYDIR/$repo" &> /dev/null
      logk
    else
      log "Skipping $repo, already exists."
      if [ -n "$pull" ] && [ "$pull"="pull" ]; then
        logn "Pulling $repo:"
        cd $BARKLYDIR/$repo && git pull &>/dev/null
        logk
      fi
    fi
  done < $repos
}
