#!/usr/bin/env sh

if [ "$#" -lt 1 ]; then
  echo "Usage:"
  echo "  make_project.sh <new_dir_name>"
  exit 1
fi

NEW_DIR=$1

mkdir -p $NEW_DIR
cp -R project_template/* $NEW_DIR/
