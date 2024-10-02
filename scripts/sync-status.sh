#!/usr/bin/env bash

output() {
  echo "{\"text\": \"\", \"tooltip\": \"$1\", \"class\": \"$2\"}"
  exit
}

if [[ $(systemctl --user is-active sync.service) == 'activating' ]]; then
  output 'syncing...' running
fi

# warn if yubikey not connected
if ! gpg --card-status > /dev/null 2>&1; then
  output 'gpg card (yubikey) not connected' error
fi

# see if sync more than 20 min age
twenty_min_ago=$(date -d '20 minutes ago' +%s)
last_sync=$(cat ~/.cache/sync-date)
last_sync_human=$(date -d "$last_sync" '+%x %X')
last_sync_epoch=$(date -d "$last_sync" +%s)
if (( last_sync_epoch < twenty_min_ago )) ; then
  output "last sync at $last_sync_human" warning
fi

output "last sync at $last_sync_human"
