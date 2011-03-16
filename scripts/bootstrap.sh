#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

SELF="etc lib scripts"

main () {
  USERNAME="$1"
  HOST="$2"
  PORT=${3:-"22"}
  ID=$4

  if [ $ID ]; then
    ID="-i $ID";
  fi

  init
}

init () {
  prompt "public key" "~/.ssh/id_rsa.pub" publickey

  publickey=`eval "echo $publickey"`

  if [ ! -f $publickey ]; then
    log "key file \'$publickey\' not found!"
    exit 1
  fi

  log "copying files to remote host.."

  echo ". scripts/boot.sh $USERNAME" > /tmp/.profile

  scp -q -r -C -P $PORT $ID $SELF /tmp/.profile $publickey root@$HOST:

  log "connecting to remote host $HOST.."

  ssh -p $PORT $ID root@$HOST
}

main "$@"
