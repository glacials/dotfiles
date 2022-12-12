#!/bin/bash
set -euxo pipefail

extraArgs=""

_setArgs(){
  while [ "${1:-}" != "" ]; do
    case "$1" in
      "--stagger")
        # shift  # uncomment if this option takes an arg (access with $1)
        # Sleep random duration to reduce chances of conflicts w/ multiple machines
        sleep $((RANDOM % 3600))
        ;;
      "--email")
        # shift  # uncomment if this option takes an arg (access with $1)
        extraArgs="$extraArgs --email"
        ;;
    esac
    shift
  done
}

_setArgs $*

REPO=/tmp/pottytrain

if [ -d $REPO ]; then
  cd $REPO
  git pull
else
  git clone git@github.com:glacials/pottytrain $REPO
  cd $REPO
fi

cp -f ~/icloud/Documents/storage/secrets/mailgun.key /tmp/pottytrain/mailgun.key

/tmp/pottytrain/main.py $extraArgs
