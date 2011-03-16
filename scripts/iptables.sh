#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

main () {
  local rules="etc/iptables/iptables.rules"

  log "copying $BIRTH_ROOT/$rules -> /$rules"
  
  cp $BIRTH_ROOT/$rules /$rules

  ask "edit /$rules? [Y/n]" && $EDITOR /$rules

  log "starting iptables daemon.."

  /etc/rc.d/iptables start
}

main "$@"
