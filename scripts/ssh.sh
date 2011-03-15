#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

main () {
  local username=$1
  local authorized_keys="/home/$username/.ssh/authorized_keys"

  log "generating ssh key pair for $username.."

  sudo -u $username -i ssh-keygen -t rsa

  log "copying public key to $authorized_keys"

  # Copy public key to user's authorized_keys
  cat /tmp/id_rsa.pub >> $authorized_keys
}

main "$@"
