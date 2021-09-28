#!/bin/bash

# hard-coded directory path
cd /home/eric/.todo
# just ossume ssh-agent is running and env is set in the file
# this is done in `.bashrc`, so it should be fine
source "$XDG_RUNTIME_DIR/ssh-agent.env"

git pull
git commit -am 'Updated todos'
git push
