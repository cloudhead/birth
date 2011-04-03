#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

main () {
  local version=""

  echo -e -n "$MARKER node version: "

  read version

  log "installing node v$version.."

  # Node
  cd /tmp
  wget -nv http://nodejs.org/dist/node-v$version.tar.gz || return 1
  tar -xzf node-v$version.tar.gz

  cd node-v$version
  ./configure && make && make install || return 1

  log "installing npm.."

  # NPM & Node packages
  curl -sS http://npmjs.org/install.sh | sh

  log "installing node modules.."

  npm install http-console journey node-static vows less syslog resourcer redis
}

main "$@"
