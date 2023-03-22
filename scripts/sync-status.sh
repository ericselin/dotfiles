#!/usr/bin/env bash

output() {
  echo "{\"text\": \"$1\", \"tooltip\": \"$2\", \"class\": \"$3\"}"
  exit
}

if [ "$1" == "sync" ]; then
  systemctl --user start sync
  pkill -SIGRTMIN+8 waybar
  exit
fi

# warn if yubikey not connected
if ! gpg --card-status > /dev/null 2>&1; then
  output 'not syncing' 'gpg card (yubikey) not connected' warning
fi

# see if sync more than 20 min age
now=$(date +%s)
lastsync=$(systemctl --user show sync -P ExecMainStartTimestamp)
lastsyncepoch=$(date -d "$lastsync" +%s)
if (( $now - $lastsyncepoch > 20 * 60 )) ; then
  output 'sync delay' "last sync at $lastsync" warning
fi
