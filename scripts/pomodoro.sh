#!/bin/bash

if [ "$1" == 'stop' ];
then
  echo 'Stopping pomodoro'
  killall -SIGUSR2 pomodoro-service.sh
else
  echo 'Starting pomodoro'
  killall -SIGUSR1 pomodoro-service.sh
fi

