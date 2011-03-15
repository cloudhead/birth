#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

main () {
  USERNAME="$1"
  HOST="$2"
  PORT=${3:-"22"}

  init
}

init () {
  prompt "public key" "~/.ssh/id_rsa.pub" publickey

  publickey=`eval "echo $publickey"`

  if [ ! -f $publickey ]; then
    log "key file \'$publickey\' not found!"
    exit 1
  fi

  log "connecting to remote host $HOST.."

  scp -q -r -C -P $PORT $PWD $publickey root@$HOST:/tmp

  log "copying files to remote host.."

  remote "/tmp/birth/scripts/boot.sh $USERNAME"
}

remote () {
  ssh -p $PORT root@$HOST "$1"
}

main "$@"
