#!/bin/bash

set -e

export BIRTH_ROOT=/root

source $BIRTH_ROOT/lib/include.sh

main () {
  local username=$1

  log "birthing `uname -nm`."

  if [ "`whoami`" != "root" ]; then
    log "birth must be run as root."
    exit 1
  fi

  export EDITOR=vim
  export PATH="/usr/local/bin:$PATH"

  trap interrupt SIGINT

  birth "sys"      "update and install system packages" $@
  birth "http"     "setup http related services"        $@
  birth "dotfiles" "setup admin dotfiles"               $@
  birth "ssh"      "setup sshd"                         $@
  birth "node"     "download & install node"            $@
  birth "sudo"     "setup sudo for admin"               $@

  log "birthing ${BOLD}complete${CLEAR}."

  cleanup

  log "logging out."

  exit 0
}

interrupt () {
  echo
  log "caught SIGINT."
  cleanup
  exit 0
}

cleanup () {
  log "cleaning up.."

  rm -rf $BIRTH_ROOT/scripts
  rm -rf $BIRTH_ROOT/lib
  rm -rf $BIRTH_ROOT/etc
  rm     $BIRTH_ROOT/.profile
  rm     $BIRTH_ROOT/id_rsa.pub
}

birth () {
  local step="$1"

  shift

  local desc="$1"

  shift

  echo -ne "$MARKER birth ${BOLD}$step${CLEAR} ${GREY}($desc)${CLEAR} "

  ask "[Y/n]?" || return 0

  log "birthing ${BOLD}$step${CLEAR}.."

  $BIRTH_ROOT/scripts/$step.sh $@ || log "$step birth failed."
}

main "$@"
