if [ "$(tty)" = "/dev/tty1" ]; then
    export GRIM_DEFAULT_DIR=$HOME/cloud/Screenshots
    exec sway
fi
