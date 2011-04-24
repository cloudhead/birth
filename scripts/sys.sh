#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

PACKAGES="bash zsh gcc make util-linux-ng python python2 python2-distribute \
          ack bind htop strace vim wget syslog-ng dhcpcd gawk pacman        \
          iputils logrotate coreutils dcron git"

main () {
  log "updating system..."

  pacman-db-upgrade                   # Upgrade database file format
  pacman --noconfirm -Syu || return 1 # This will just update pacman
  pacman --noconfirm -Syu || return 1 # Now we actually update everything else

  log "installing packages..."

  pacman --noconfirm -S $PACKAGES || return 1

  log "linking python."

  # Link 'python' to `python2'
  ln -s -f /usr/bin/python2 /usr/bin/python

  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  echo "en_US ISO-8859-1"  >> /etc/locale.gen

  locale-gen

  ask "edit /etc/rc.conf? [Y/n]" && $EDITOR /etc/rc.conf

  return 0
}

main "$@"
