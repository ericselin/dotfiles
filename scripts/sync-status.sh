#!/bin/bash

services="mbsync outlook-calendar-sync vdirsyncer todo-sync"

if [ "$1" == "sync" ]; then
  systemctl --user start $services
  exit $?
fi

output() {
  local status=$(systemctl --user show $services -p Id,ExecMainStatus,ActiveState,ExecMainStartTimestamp)
  # first replace newline with tab to get everything on one line so sed is happy
  # then substitute tab with literal '\n'
  local tooltip=$(echo -n "$status" | tr '\n' '\t' | sed 's/\t/\\n/g')
  echo "{\"text\": \"$1\", \"tooltip\": \"$tooltip\", \"class\": \"$2\"}"
  exit
}
# output all info

# see if anything has failed
systemctl --user is-failed $services --quiet
# exit code is 0 if something has failed
if [ $? -eq 0 ] ; then
  output 'sync failure' error
fi

# see if sync more than 20 min age
now=$(date +%s)
systemctl --user show $services -P ExecMainStartTimestamp | grep -v '^$' | while read time;
do
  epoch=$(date -d "$time" +%s)
  if (( $now - $epoch > 20 * 60 )) ; then
    output 'sync delay' warning
  fi
done
