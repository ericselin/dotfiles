# Sync work Outlook

# owa public calendar link
WORK_CAL_URL='https://outlook.office365.com/owa/calendar/a41faac0cabe4f5285bbda6a3d8858db@reima.com/f77e734af0134376a7202f19a10b92f616628265132000424590/calendar.ics'
# curl the file, -s is for silent mode (i.e. output contents only)
# sed replace google UID with @, see https://github.com/pimutils/khal/issues/1045
# import into khal
curl -s $WORK_CAL_URL | sed -r 's/(UID:.*)@google.com/\1ATgoogle/' | khal import --batch -a reima
