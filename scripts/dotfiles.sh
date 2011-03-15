#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

main () {
  local username=$1
  local url=

  echo birth: retrieving dotfiles...

  prompt "dotfiles repo" "git://github.com/$username/dotfiles.git" url

  # Initialize user settings
  sudo -u $username git clone $url /home/$username
}

main "$@"
