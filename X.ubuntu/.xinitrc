#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
# pkill X to kill X server
# logs are in /var/log/Xorg.0.log
# always append command with & to reduce the delay before launch display manager


#set -x# activate debugging from here


# without this terminals spawned from window manager will not be utf-8
export LANG="${LANG:-en_US.UTF-8}"
exec gnome-session
