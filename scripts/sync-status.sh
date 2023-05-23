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
twenty_min_ago=$(date -d '20 minutes ago' +%s)
last_log=$(cat ~/.cache/sync-date)
last_log_epoch=$(date -d "$last_log" +%s)
if (( last_log_epoch < twenty_min_ago )) ; then
  output 'sync delay' "last sync at $last_log" warning
fi
