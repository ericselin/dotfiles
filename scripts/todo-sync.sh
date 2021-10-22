#!/bin/bash

# hard-coded directory path
cd /home/eric/.todo

git pull
git commit -am 'Updated todos'
git push
