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
  # kill sleep background process
  kill $(jobs -p)
  exit 1
}
trap cleanup SIGINT SIGTERM

# seconds for reporting
start_time=$SECONDS

for minutes in {0..24}
do
  echo "Pomodoro running for $minutes minutes"
  # this is the progress bar length
  bar=$(printf '%-'$minutes's' | sed 's/ /\*/g')
  echo "[$(printf '%-25s' $bar)]" > ~/pomodoro
  # refresh i3status
  refresh_i3status
  # wait for a sleep in order to be able to trap signals
  sleep 60 & wait
done

echo "Ran for $(( $SECONDS - $start_time )) seconds"

# signal to i3status that nothing is running
rm ~/pomodoro
refresh_i3status
# notify the user
notify-send 'Pomodoro finished!' 'Now take a well deserved break :)'
