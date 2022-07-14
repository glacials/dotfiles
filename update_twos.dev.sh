#!/bin/bash

# Sleep random duration to reduce chances of conflicts w/ multiple machines
sleep $((RANDOM % 3600))
PUBLISHED="/Users/glacials/Library/Mobile Documents/27N4MQEA55~pro~writer/Documents/Published/"
REPO=/tmp/twos.dev

if [ -d $REPO ]; then
  cd $REPO
  git pull
else
  git clone git@github.com:glacials/twos.dev $REPO
  cd $REPO
fi

cp -r "$PUBLISHED" "$REPO/src/warm"
git add src/warm
git commit -m "Automatic commit by iA Writer cron job"
git push
