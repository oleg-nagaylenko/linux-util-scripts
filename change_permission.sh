#!/bin/bash

# This script changes the permissions on the specified files or directories.
#
# The script finds all files/directories matching the passed name pattern
# starting from the specified base directory and changes their permissions.
#
# By default the script will only search for FILES. To change this use flags: -d or -fd
#
# -b  | --base-directory    - the base directory from where the recursive search will occur, current directory by default.
# -n  | --name-pattern      - the pattern for files\directories that need to change permissioms, all by default.
# -p  | --permissions       - values that will be applied to files that match the pattern, '+rw' by default.
# -d  | --directories       - defines search for directories only.
# -fd | --files-directories - defines search for files and directories.

ORANGE='\033[0;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

DIR_FLAG=0
ALL_FLAG=0

BASE_DIRECTORY='.'
PATTERN='*'
PERMISSIONS="+rw"

while [ $# -gt 0 ]; do
  case $1 in
    -b | --base-directory)
      BASE_DIRECTORY="$2"
      shift 2 ;;
    -n | --name-pattern)
      PATTERN="$2"
      shift 2 ;;
    -p | --permissions)
      PERMISSIONS="$2"
      shift 2 ;;
    -d | --directories)
      DIR_FLAG=1
      shift 1 ;;
    -fd | --files-directories)
      ALL_FLAG=1
      shift 1 ;;
    *)
      echo "Unknown option $1"
      exit 1 ;;
  esac
done

if [ $ALL_FLAG -eq 1 ]
then
  TARGETS=$(find "${BASE_DIRECTORY}" -type f -name "${PATTERN}" -o -type d -name "${PATTERN}")
  echo -e "\nFound files and directories: \n${TARGETS}\n"
elif [ $DIR_FLAG -eq 1 ]
then
  TARGETS=$(find "${BASE_DIRECTORY}" -type d -name "${PATTERN}")
  echo -e "\nFound directories: \n${TARGETS}\n"
else
  TARGETS=$(find "${BASE_DIRECTORY}" -type f -name "${PATTERN}")
  echo -e "\nFound files: \n${TARGETS}\n"
fi

echo -ne "${ORANGE}Are you sure you wanna change permissions? [y/n] ${NC}"
read -n 1 -r

echo
if [ $REPLY = 'y' ]
then
  echo ${TARGETS} | xargs chmod ${PERMISSIONS}
  echo -e "\n${GREEN}Permissions have been changed${NC}\n"  
  exit 0
fi

echo -e "\n${RED}Permissions have not been changed${NC}\n"
exit 1
