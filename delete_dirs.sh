#!/bin/bash

TARGET_DIRECTORIES=$(find . -type d -name "target*")

echo -e "Directories: \n$TARGET_DIRECTORIES\n"

read -p "Are you sure you wanna delete these directories? [y/n] " -n 1 -r
echo
if [[ $REPLY = 'y' ]] 
then
  echo $TARGET_DIRECTORIES | xargs -t rm -rf
fi
