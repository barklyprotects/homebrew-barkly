#!/bin/bash

BASEDIRFILE=$(dirname $0)
cd $BASEDIRFILE
BASEDIR=$(pwd -P)

echo "Installing Fusion"
vagrant plugin install vagrant-vmware-fusion
USER_GITHUB=$(git config --global github.user)
echo "Licensing vmware-fusion"
vagrant plugin license vagrant-vmware-fusion $BARKLYDIR/licenses/vagrant-vmware-fusion/$USER_GITHUB/license.lic
