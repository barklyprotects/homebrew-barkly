#!/bin/bash
# Library of functions for use in project files

# Portions of this file are
# Copyright (C) 2015 by Mike McQuaid

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

abort() { STRAP_STEP="";   echo "!!! $*" >&2; exit 1; }
alert() { STRAP_STEP="$*"; echo "!!! $*"; }
log()   { STRAP_STEP="$*"; sudo_init; echo "--> $*"; }
logn()  { STRAP_STEP="$*"; sudo_init; printf -- "--> %s " "$*"; }
logk()  { STRAP_STEP="";   echo "OK"; }

checkInit() {
  if ! [ $BARKLYDIR ]; then
    echo Barkly directroy not defined.
    echo Please run from brew barkly instead.
    exit 1
  fi
}

# Copied from https://github.com/MikeMcQuaid/strap/blob/0ac782c7ddc6972f10e05cf611d4a70d46c441d8/bin/strap.sh#L55-L66
# Initialise (or reinitialise) sudo to save unhelpful prompts later.
sudo_init() {
  if ! sudo -vn &>/dev/null; then
    if [ -n "$BREWBARKLY_SUDOED_ONCE" ]; then
      echo "--> Re-enter your password (for sudo access; sudo has timed out):"
    else
      echo "--> Enter your password (for sudo access):"
    fi
    sudo /usr/bin/true
    BREWBARKLY_SUDOED_ONCE="1"
  fi
}

setupSudo() {
  # We want to ask for sudo permissions quickly when this is run.
  sudo -k
}

gatekeeperDisable() {
  log "Modifying gatekeeper to allow all apps to install: "
  sudo spctl --master-disable
  logk
}

gatekeeperEnable() {
  log "Resetting gatekeeper to prompt for app security: "
  sudo spctl --master-enable
  logk
}

setupBarklyDir() {
  if [ -d "$HOME/cylent" ] && ! [ -L "$HOME/cylent" ]; then
    # log "Using existing cylent directory."
    # Do nothing if link already exists
    if ! [ -L "$HOME/barkly" ]; then
      logn "Symlinking barkly dir:"
      ln -sv "$HOME/cylent" "$HOME/barkly"
      logk
    fi
    BARKLYDIR="$HOME/cylent"
  else
    # log "Using barkly home directory."
    mkdir -p "$HOME/barkly"
    if ! [ -L "$HOME/cylent" ]; then
      logn "Creating cylent symlink for now:"
      ln -sv "$HOME/barkly" "$HOME/cylent"
      logk
    fi
    BARKLYDIR="$HOME/cylent"
  fi
  export BARKLYDIR
}

cloneRepos() {
  repos=$1
  while read REPO; do
    # Skip comments and empty lines
    [[ $REPO == \#* ]] || [ -z "$REPO" ] && continue

    repoArray=($REPO)
    repo="${repoArray[0]}"
    pull="${repoArray[1]}"

    if ! [ -d "$BARKLYDIR/$repo" ]; then
      logn "Cloning $repo into $BARKLYDIR/$repo:"
      $dryRun git clone --recursive https://github.com/barklyprotects/$repo.git "$BARKLYDIR/$repo" &> /dev/null
      logk
    else
      log "Skipping $repo, already exists."
      if [ -n "$pull" ] && [ "$pull" = "pull" ]; then
        logn "Pulling $repo:"
        cd $BARKLYDIR/$repo && $dryRun git pull &>/dev/null
        logk
      fi
    fi
  done < $repos
}

startApps() {
  apps=$1

  if ! [ -f "$apps" ]; then
    return
  fi

  while read APP; do
    # Skip comments and empty lines
    [[ $APP == \#* ]] || [ -z "$APP" ] && continue

    logn "Starting $APP:"
    if [[ "$APP" == *.app ]]; then
      open -a "$APP"
    else
      open "$APP"
    fi
    logk

  done < $apps
}

cleanup() {
  # Turning gatekeeper back on for security
  gatekeeperEnable
  exit
}

trap cleanup SIGINT

setupBarklyDir
