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
mbsync -Va
msmtp-queue -r
# check the queue is now empty (msmtp-queue exit code is always 0)
if [ "$(ls -A $HOME/.msmtp.queue)" ]; then
  exit 1
fi
# index emails
notmuch new

__heading 'syncing git repositories'
cd "$REPO_DIR"
for d in */ ; do
  echo "processing $d"
  cd "$d"
  if [ -d .git ]; then
    git fetch --all
    git push --all
  fi
  cd "$REPO_DIR"
done


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
date -Iseconds > ~/.cache/sync-date
pkill -RTMIN+8 waybar
echo Done!
