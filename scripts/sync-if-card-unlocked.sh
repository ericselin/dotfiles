#!/bin/sh

if ! gpg --card-status > /dev/null 2>&1; then
  echo 'Key not inserted'
  exit 1
fi

set -e

__heading () {
  echo
  echo '================='
  echo "$1"
  echo '================='
  echo
}

__heading 'syncing calendar...'
vdirsyncer sync

__heading 'syncing email...'
mbsync -Va

__heading 'syncing passwords...'
gopass sync

__heading 'updating date and waybar...'
date -Iseconds > ~/.cache/sync-date
pkill -RTMIN+8 waybar
echo Done!
