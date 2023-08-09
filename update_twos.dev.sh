#!/bin/bash
set -euxo pipefail

_setArgs(){
  while [ "${1:-}" != "" ]; do
    case "$1" in
      "--stagger")
        # shift  # uncomment if this option takes an arg
        # Sleep random duration to reduce chances of conflicts w/ multiple machines
        sleep $((RANDOM % 3600))
        ;;
    esac
    shift
  done
}

_setArgs $*

iAWriter="/Users/glacials/Library/Mobile Documents/27N4MQEA55~pro~writer/Documents/Published"
Obsidian="/Users/glacials/notesmd/Writing/twos.dev"

REPO=/tmp/twos.dev

if [ -d $REPO ]; then
  cd $REPO
  git pull
else
  git clone git@github.com:glacials/twos.dev $REPO
  cd $REPO
fi

# Trailing slashes in sources makes us copy dir contents, not dir
cp -r "$Obsidian/" "$REPO/src/warm"
git add src/warm
git commit -m "Automatic commit by iA Writer cron job"
git push
