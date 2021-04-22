#!/bin/bash

LOG="$HOME/.backup_log"
BACKUP_MOUNT="/backup"

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG
}

warn() {
  echo "WARNING: $(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG
}

log 'Mounting backup drive'

# open backup drive
# this assumes that backup is defined in crypttab
sudo systemctl start systemd-cryptsetup@backup.service
# mount backup drive
sudo mount /dev/mapper/backup $BACKUP_MOUNT

if [ ! -f "$BACKUP_MOUNT/.backup_drive" ]
then
  echo "ERROR! Could not find '$BACKUP_MOUNT/.backup_drive'"
  exit 1
fi

log "Starting backup to $BACKUP_MOUNT"

# Go to backup dir
cd $BACKUP_MOUNT

log 'Backing up: GitHub'

# Pull changes from remote or clone if not existing
# Takes the name of a personal repo as an argument
pull_or_clone() {
  (cd $1 && git pull && cd ..) || gh repo clone $1 || warn "Could not backup github repo $1"
}
mkdir -p github
cd github
repos=$(gh repo list | sed -nr 's/^\S+\/(\S+).*$/\1/p')
for repo in $repos; do
  pull_or_clone $repo
done
cd ..

log 'Backing up: gmail'

mbsync -a
mkdir -p mail
rclone sync ~/.mail mail --progress

log 'Backing up: google drive'

mkdir -p google-drive
rclone sync gdrive:/ google-drive --progress
if [ $? -gt 0 ]
then
  rclone config reconnect gdrive:
  rclone sync gdrive:/ google-drive
fi

warn 'Not backing up: google photos'
warn 'Not backing up: google keep'
warn 'Not backing up: google calendar'
warn 'Not backing up: google contacts'
warn 'Not backing up: bookmarks'

log 'Unmounting backup drive'
sudo systemctl stop systemd-cryptsetup@backup.service
sudo umount $BACKUP_MOUNT
