#!/bin/bash -f

for minutes in {0..25}
do
  echo "Pomodoro running for $minutes minutes"
  # this is the progress bar length
  bar=$(printf '%-'$minutes's' | sed 's/ /\*/g')
  echo "[$(printf '%-25s' $bar)]" > ~/pomodoro
  sleep 60 
done

# signal to i3status that nothing is running
rm ~/pomodoro
