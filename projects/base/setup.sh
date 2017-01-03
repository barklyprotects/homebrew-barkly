#!/bin/bash

BASEDIRFILE=$(dirname $0)
cd $BASEDIRFILE
BASEDIR=$(pwd -P)

echo "Installing Fusion"
vagrant plugin install vagrant-vmware-fusion
USER_GITHUB=$(git config --global github.user)

echo "Licensing vmware-fusion"
if [ -d "$BARKLYDIR/licenses/vagrant-vmware-fusion/$USER_GITHUB" ]; then
  vagrant plugin license vagrant-vmware-fusion $BARKLYDIR/licenses/vagrant-vmware-fusion/$USER_GITHUB/license.lic
else
  echo "Vagrant vmware fusion plugin license not found."
  echo "Please add to licenses github repo."
fi
