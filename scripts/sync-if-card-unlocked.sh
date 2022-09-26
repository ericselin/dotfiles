#!/bin/sh

if gpg --card-status
then
  systemctl --user start --wait sync
fi
