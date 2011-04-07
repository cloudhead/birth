#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

main () {
  local path="etc/resolv.conf.head"

  log "copying resolv.conf.head to /etc"

  cp $BIRTH_ROOT/$path /$path
}

main "$@"
