# Sync work Outlook
WORK_CAL_URL='https://outlook.office365.com/owa/calendar/a41faac0cabe4f5285bbda6a3d8858db@reima.com/f77e734af0134376a7202f19a10b92f616628265132000424590/calendar.ics'
curl -s $WORK_CAL_URL | khal import --batch -a reima
