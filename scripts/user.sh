#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

main () {
  local user=$1
  local shell=

  log "creating user $user"

  prompt "shell for $user" "/bin/zsh" shell

  which $shell &> /dev/null || (log "$shell not found!" && return 1)

  [ -e /home/$user ] && userdel -r $user

  useradd $user -m -s $shell      # Create new user and home directory
  passwd  $user                   # Set UNIX password
  usermod -a -G wheel $user       # Add user to admin ('wheel') group
  usermod -a -G users $user

  log "setting up home directory for $user"

  sudo -u $user  mkdir -p  /home/$user/src                  # Create source-code directory
  sudo -u $user  mkdir -p  /home/$user/.ssh                 # Create ssh directory
  sudo -u $user  touch     /home/$user/.ssh/authorized_keys # Create authorized_keys file
  sudo -u $user  chmod 700 /home/$user/.ssh                 # Restrict permissions to .ssh folder
  sudo -u $user  chmod 600 /home/$user/.ssh/authorized_keys # Restrict permissions to authorized_keys
}

main "$@"

