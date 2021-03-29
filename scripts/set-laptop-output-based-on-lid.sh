#!/usr/bin/bash

# This script turns the internal screen on or off based
# on the current state of the lid
# https://github.com/swaywm/sway/wiki#clamshell-mode
# Takes one argument, which is the name of the output

if grep -q open /proc/acpi/button/lid/LID/state; then
  swaymsg output $1 enable
else
  swaymsg output $1 disable
fi
