#!/bin/bash

LOG="$HOME/.backup_log"
BACKUP_MOUNT="/backup"

log() {
  echo "INFO:    $(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG
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

log 'Backing up: gpg'
mkdir -p gnupg
rclone sync ~/.gnupg gnupg

log 'Backing up: ssh'
rclone sync ~/.ssh ssh

log 'Backing up: GitHub'

warn 'Not pushing potential git changes'

# Pull changes from remote or clone if not existing
# Takes the name of a personal repo as an argument
pull_or_clone() {
  local giturl="ssh://git@github.com/$1.git"
  (cd $1 2> /dev/null && git pull && cd ..) || git clone $giturl || warn "Could not backup github repo $1"
}
mkdir -p github
cd github
repos=$(gh repo list | grep -Eo '^\w+/\w+')
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
sudo umount -l $BACKUP_MOUNT
