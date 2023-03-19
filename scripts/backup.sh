#!/bin/bash

export BACKUP_LOG="$HOME/.backup_log"
export BACKUP_MOUNT="/backup"

log() {
  echo "INFO:    $(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $BACKUP_LOG
}

warn() {
  echo "WARNING: $(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $BACKUP_LOG
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

run-parts ~/scripts/backup.home.d --arg=backup

run-parts ~/scripts/backup.cloud.d

log 'Backing up: email'

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
sudo umount -l $BACKUP_MOUNT
