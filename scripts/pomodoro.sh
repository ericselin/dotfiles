#!/bin/bash

if [ "$1" == 'stop' ];
then
  echo 'Stopping pomodoro'
  killall -SIGUSR2 pomodoro-service
else
  echo 'Starting pomodoro'
  killall -SIGUSR1 pomodoro-service
fi

