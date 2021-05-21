#!/bin/bash -f

start_pomodoro()
{
  # check if pomodoro running and exit if it is
  [ ! $running ] || return

  # now we are running a timer
  running='y'

  # seconds for reporting
  start_time=$SECONDS

  for minutes in {0..24}
  do
    # check that we're still running
    [ $running ] || return

    # this is the progress bar length
    bar=$(printf '%-'$minutes's' | sed 's/ /\*/g')

    local text=" [$(printf '%-25s' $bar)]"
    local tooltip="$((25-minutes)) min left"
    local class='running'

    echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"

    # wait for a sleep
    sleep 60 & 
    id=$!
    wait $id
  done

  # notify the user
  notify-send 'Pomodoro finished!' 'Now take a well deserved break :)'

  reset
}

# reset the ui and set running to false
reset()
{
  running=
  echo '{"text":" Start pomodoro!","percentage":100}'
}

cleanup()
{
  # kill all sleeps background process
  kill $(jobs -p)
  exit 1
}

# listen to signal to start pomodoro
trap start_pomodoro SIGUSR1
# listen to pomodoro stop
trap reset SIGUSR2
# cleanup on kill
trap cleanup SIGINT SIGTERM

reset

while :
do
  # we need to sleep here, because signals don't reach the script
  # launched for waybar if doing read
  # we need to wait in order to interrupt the signal when sleeping
  sleep 10m & wait
done

