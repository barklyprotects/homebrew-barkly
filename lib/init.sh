#!/bin/bash
# Library of functions for use in project files

abort() { STRAP_STEP="";   echo "!!! $*" >&2; exit 1; }
alert() { STRAP_STEP="$*"; echo "!!! $*"; }
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

setupBarklyDir() {
  if [ -d "$HOME/cylent" ]; then
    # log "Using existing cylent directory."
    # Do nothing if link already exists
    if ! [ -h "$HOME/barkly" ]; then
      logn "Symlinking barkly dir:"
      ln -sv "$HOME/cylent" "$HOME/barkly"
      logk
    fi
    BARKLYDIR="$HOME/cylent"
  else
    # log "Using barkly home directory."
    mkdir -p "$HOME/barkly"
    if ! [ -h "$HOME/cylent"]; then
      logn "Creating cylent symlink for now:"
      ln -sv "$HOME/barkly" "$HOME/cylent"
      logk
    fi
    BARKLYDIR="$HOME/cylent"
  fi
  export BARKLYDIR
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

setupBarklyDir
