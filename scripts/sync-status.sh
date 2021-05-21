#!/bin/bash
systemctl --user show mbsync outlook-calendar-sync vdirsyncer -p Id,ExecMainStatus,ActiveState,ExecMainStartTimestamp
