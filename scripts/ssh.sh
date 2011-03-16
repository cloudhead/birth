#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

main () {
  local username=$1
  local authorized_keys="/home/$username/.ssh/authorized_keys"
  local sshd_config="etc/ssh/sshd_config"

  log "generating ssh key pair for $username.."

  sudo -u $username -i ssh-keygen -t rsa

  log "copying public key to $authorized_keys"

  # Copy public key to user's authorized_keys
  cat $BIRTH_ROOT/id_rsa.pub >> $authorized_keys

  log "copying $BIRTH_ROOT/$sshd_config -> /$sshd_config"

  cp $BIRTH_ROOT/$sshd_config /$sshd_config

  while :; do
    ask "edit /$sshd_config? [Y/n]" && $EDITOR /$sshd_config

    log "restarting sshd.."

    /etc/rc.d/sshd restart

    ask "now are you able to connect with user $username? [Y/n]" && break
  done

  ask "restrict ssh access to $username? [Y/n]" && echo "AllowUsers $username" >> /$sshd_config

  return 0
}

main "$@"
