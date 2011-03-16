#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

main () {
  local username=$1

  cd $BIRTH_ROOT/lib/home

  log "copying files to home directory.."

  # Copy dotfiles to home directory
  cp    -r {.zshrc,.profile,.vimrc,.vim} /home/$username/
  chown -R $username:$username           /home/$username/

  cd $BIRTH_ROOT
}

main "$@"
