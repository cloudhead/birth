#!/bin/bash

ESC="\033"
BLUE="$ESC[34m"
BOLD="$ESC[1m"
GREY="$ESC[90m"
CLEAR="$ESC[0m"
MARKER=" $BLUE*$CLEAR"

log () {
  echo -e "$MARKER $1"
  return 0
}

ask () {
  local answer=

  echo -n "$1 "
  read answer

  if [ "$answer" = "y" ] || [ -z "$answer" ]; then
    return 0
  else
    return 1 
  fi
}

prompt () {
  local answer=

  echo -en "$MARKER enter $1 ($2): "
  read answer

  eval $3=${answer:-$2}
}
