#!/bin/bash

BASEDIRFILE=$(dirname $0)
cd $BASEDIRFILE
BASEDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

logn "Installing Fusion vagrant plugin: "
vagrant plugin install vagrant-vmware-fusion &> /dev/null
logk

logn "Licensing vmware-fusion"
USER_GITHUB=$(git config --global github.user)
if [ -d "$BARKLYDIR/licenses/vagrant-vmware-fusion/$USER_GITHUB" ]; then
  vagrant plugin license vagrant-vmware-fusion $BARKLYDIR/licenses/vagrant-vmware-fusion/$USER_GITHUB/license.lic &> /dev/null
  logk
else
  log "Vagrant vmware fusion plugin license not found."
  log "Please add to licenses github repo."
fi
