#!/bin/bash -f

# i3status refresh alias for convenience
refresh_i3status()
{
  killall -SIGUSR1 i3status
}

# listen for SIGINT and remove file if terminated
cleanup()
{
  rm ~/pomodoro
  refresh_i3status
  exit 1
}
trap cleanup SIGINT

for minutes in {0..25}
do
  echo "Pomodoro running for $minutes minutes"
  # this is the progress bar length
  bar=$(printf '%-'$minutes's' | sed 's/ /\*/g')
  echo "[$(printf '%-25s' $bar)]" > ~/pomodoro
  # refresh i3status
  refresh_i3status
  # time the timer
  sleep 60
done

# signal to i3status that nothing is running
rm ~/pomodoro
refresh_i3status
# notify the user
i3-nagbar -m 'Pomodoro finishd! Take a well deserved break :)' -t warning
