#!/bin/bash

# output all info
systemctl --user show mbsync outlook-calendar-sync vdirsyncer -p Id,ExecMainStatus,ActiveState,ExecMainStartTimestamp

services="mbsync outlook-calendar-sync vdirsyncer"

# see if anything has failed
_=$(systemctl --user show $services -p ActiveState | grep -F 'ActiveState=failed')
# check exit code here
if [ $? -eq 0 ] ; then
  echo ''
  echo 'FAILED COMMANDS!'
fi
