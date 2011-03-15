#!/bin/bash

source $BIRTH_ROOT/lib/include.sh

main () {
  log "uncomment '%wheel  ALL=(ALL) ALL'\
       to allow users in group 'wheel' to run \`sudo\`."

  echo -n "$MARKER [return] to launch visudo. "
  read

  visudo
}

main "$@"
