#!/bin/bash

# -d    | --base-directory - the base directory from where the recursive search will occur, current directory by default.
# -f    | --file-pattern   - the pattern for files that need to change permissioms, all files by default.
# -p    | --permissions    - values that will be applied to files that match the pattern, +rw by default.

ORANGE='\033[0;33m'
NC='\033[0m'

BASE_DIRECTORY="."
PATTERN="*"
PERMISSIONS="+rw"

while [[ $# -gt 0 ]]; do
  case $1 in
    -d | --base-directory)
      BASE_DIRECTORY="$2"
      shift 2 ;;
    -f | --file-pattern)
      PATTERN="$2"
      shift 2 ;;
    -p | --permissions)
      PERMISSIONS="$2"
      shift 2 ;;
    *)
      echo "Unknown option $1"
      exit 1 ;;
  esac
done

TARGET_FILES=$(find "${BASE_DIRECTORY}" -type f -name "${PATTERN}")

echo -e "Files: \n$TARGET_FILES\n"

echo -ne "${ORANGE}Are you sure you wanna change permissions for these files? [y/n] ${NC}"
read -n 1 -r

echo
if [[ $REPLY = 'y' ]]
then
  echo $TARGET_FILES | xargs -t chmod $PERMISSIONS  
fi
