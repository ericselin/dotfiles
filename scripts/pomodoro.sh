#!/usr/bin/env bash

if [ "$1" == 'stop' ];
then
  echo 'Stopping pomodoro'
  pkill -f -SIGUSR2 pomodoro-service.sh
else
  echo 'Starting pomodoro'
  pkill -f -SIGUSR1 pomodoro-service.sh
fi

