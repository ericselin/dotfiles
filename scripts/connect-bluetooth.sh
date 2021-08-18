#!/bin/bash

bluetoothctl power on

device=$(bluetoothctl devices | fzf --layout=reverse --height=5 --info=hidden --prompt='Connect to bluetooth device > ' | grep -Eo '(\w{2}\:?){6}')

bluetoothctl connect $device
