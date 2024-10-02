#!/bin/sh
REPO_DIR="$HOME/src/"

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

__heading 'syncing email...'
msmtp-queue -r
# check the queue is now empty (msmtp-queue exit code is always 0)
if [ "$(ls -A $HOME/.msmtp.queue)" ]; then
  exit 1
fi
mbsync -Va
# index emails
notmuch new

__heading 'syncing calendar...'
vdirsyncer sync

__heading 'syncing passwords...'
gopass sync

__heading 'syncing files...'
nextcloudcmd \
  --user admin \
  --password "$(gopass show -o 'websites/selin.cloud/admin')" \
  ~/cloud https://selin.cloud

__heading 'updating date and waybar...'
# we need to persist the sync date for reliability after reboot, because
# systemd timestamps are zero if the unit has not run during this boot cycle
date -Iseconds > ~/.cache/sync-date
echo Done!
