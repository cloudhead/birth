#!/bin/bash

set -e

export BIRTH_ROOT=/tmp/birth

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

  birth "user"     "setup admin user account"           $@
  birth "sys"      "update and install system packages" $@
  birth "http"     "setup http related services"        $@
  birth "dotfiles" "setup admin dotfiles"               $@
  birth "ssh"      "setup sshd"                         $@
  birth "node"     "download & install node"            $@
  birth "sudo"     "setup sudo for admin"               $@

  cleanup
}

cleanup () {
  log "cleaning up.."
  rm -rf $BIRTH_ROOT
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
