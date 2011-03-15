#!/bin/bash

main () {
  local username=$1
  userdel -r $username
}

main "$@"
