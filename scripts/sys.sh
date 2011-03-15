#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

PACKAGES="bash zsh gcc make util-linux-ng python python2 python2-distribute \
          ack bind htop strace vim wget syslog-ng dhcpcd gawk pacman        \
          iputils logrotate coreutils dcron git"

main () {
  log "updating system..."

  pacman --noconfirm -Syu || return 1

  log "installing packages..."

  pacman --noconfirm -S $PACKAGES || return 1

  log "linking python."

  # Link 'python' to `python2'
  ln -s -f /usr/bin/python2 /usr/bin/python

  locale-gen
}

main "$@"
