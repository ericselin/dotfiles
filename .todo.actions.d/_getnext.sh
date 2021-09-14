# Get next task for the project in question ($1)

_getnext() {
  echo
  echo "Project $1"
  echo

  $TODO_FULL_SH command ls $1

  echo
  echo 'Which task is the new next task?'
  echo 'Write a new task if needed.'
  echo 'Leave empty for no next task.'

  read next

  # exit if nothing specified
  [ -z "$next" ] && echo 'No new next task selected' && return

  # workaround check to see if number, and append in this case
  [ "$next" -eq "$next" ] 2>/dev/null && $TODO_FULL_SH command app $next +next && return

  # add if neither of the above
  # add project if not in input
  if ! echo "$next" | grep -q "$1"; then next="$next $1"; fi
  # add +next if not in input and if not +wf
  if ! echo "$next" | grep -q '+next' && ! echo "$next" | grep -q '+wf'; then next="$next +next"; fi
  # add natively
  $TODO_FULL_SH command add "$next"
}
