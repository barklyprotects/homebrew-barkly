#!/bin/bash

# Get current timestamp. Use option '-c' to copy to clipboard.
function ts {
  local iso_stamp=`date +"%Y-%m-%d %H:%M:%S"`
  if [ "$1" == "-c" ]; then
    echo -n $iso_stamp | pbcopy
    echo "[$iso_stamp] copied to clipboard."
  else
    echo $iso_stamp
  fi
}

function tmpname {
  local name=`date +"%Y-%m-%d_%H-%M-%S"`
  echo "tempfile_$name"
}
