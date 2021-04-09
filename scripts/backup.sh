#!/bin/bash

LOG="$1/.backup_log"

if [ ! -f "$LOG" ]
then
  echo "ERROR! Could not find $LOG. Are you sure this is the right dir?"
  exit 1
fi

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee $LOG
}

log "Starting backup to $1"

# Go to backup dir
cd $1

echo 'Backing up: GitHub'

# Pull changes from remote or clone if not existing
# Takes the name of a personal repo as an argument
pull_or_clone() {
  (cd $1 && git pull && cd ..) || gh repo clone $1 || echo "ERROR! Could not backup $1"
}
mkdir -p github
cd github
repos=$(gh repo list | sed -nr 's/^\S+\/(\S+).*$/\1/p')
for repo in $repos; do
  pull_or_clone $repo
done
cd ..

echo 'WARNING! Not backing up: gmail'
echo 'WARNING! Not backing up: google photos'
echo 'WARNING! Not backing up: google drive'
echo 'WARNING! Not backing up: google keep'
echo 'WARNING! Not backing up: google calendar'
echo 'WARNING! Not backing up: google contacts'
echo 'WARNING! Not backing up: bookmarks'
