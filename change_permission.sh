#!/bin/bash

# -d    | --base-directory - the base directory from where the recursive search will occur, current directory by default.
# -ptrn | --patern         - the pattern for files that need to change permissioms, all files by default.
# -prms | --permissions    - values that will be applied to files that match the pattern, +rw by default.

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
    -ptrn | --pattern)
      PATTERN="$2"
      shift 2 ;;
    -prms | --permissions)
      PERMISSIONS="$2"
      shift 2 ;;
    *)
      echo "Unknown option $1"
      exit 1 ;;
  esac
done

echo -e "\nPermissions: ${ORANGE}${PERMISSIONS}${NC} will be applied to files that matche pattern: ${ORANGE}${PATTERN}${NC} starting from directory: ${ORANGE}${BASE_DIRECTORY}${NC}\n";

find "${BASE_DIRECTORY}" -name "${PATTERN}" -type f -exec chmod "${PERMISSIONS}" {} \;
