#!/bin/bash

echo "\$1 == $1"
echo "\$2 == $2"

if [ -z "$2" ]; then
  echo 'Usage:'
  echo '  ./script-name.sh COMMAND FILE'
  echo
  echo 'Where COMMAND is one of: get, update'
  exit 1
fi


