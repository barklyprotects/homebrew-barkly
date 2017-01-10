#!/bin/bash

THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

pip install awscli
aws configure set default.s3.signature_version s3v4
