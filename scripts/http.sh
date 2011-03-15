#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

PACKAGES="nginx couchdb dnsutils bind redis snort tcpdump tcpflow iptables"

main () {
  pacman --noconfirm -S $PACKAGES

  cd /srv/http
  chown root:http .
}

main "$@"
