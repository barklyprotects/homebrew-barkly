#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

# Start your script below and user any helpsers setup in lib/init.sh
logn "Adding Kops/Kubernetes configs:"
mkdir -p "$HOME/.env" &> /dev/null
for file in $THISDIR/files/env/*; do
  cp "$file" "$HOME/.env"
done
logk

alert "Kops is setup. To use kops, make sure you source either ~/.barklyrc or ~/.env/kops.sh"
alert "In order to use kops or kubernetes, you must have the aws cli setup and have access to s3://barkly-kops"
