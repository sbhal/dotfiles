#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
# pkill X to kill X server
# logs are in /var/log/Xorg.0.log
# always append command with & to reduce the delay before launch display manager


#set -x# activate debugging from here


# debug echo check
if [[ $debug_bash == "true" ]]; then
    echo "*** /home/sbhal/.xinitrc ***"
fi

# without this terminals spawned from window manager will not be utf-8
 export LANG="${LANG:-en_US.UTF-8}"

xset +fp /usr/share/fonts/local
xset fp rehash

# set the cursor
# xsetroot -cursor_name left_ptr

# set dvorak keyboard layout
# setxkbmap -layout dvorak

# remap the caps lock key
[[ -f $HOME/.Xmodmap ]] && xmodmap $HOME/.Xmodmap
#xbindkeys &

# load Xdefaults/Xresources
# Xdefaults is deprecated and somehow Xresources
# isn't always loaded so we will load our own here
[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources
[[ -f $HOME/.xsession ]] && source $HOME/.xsession
[[ -f $HOME/.Xpersonal ]] && xrdb -merge $HOME/.Xpersonal
[[ -f $HOME/.Xfont ]] && xrdb -merge $HOME/.Xfont

# start xcompmgr so terminals have true transparency
# xcompmgr -c &
# and now put the background image back
# a fix for this should be coming in SLiM
#hsetroot -fill $HOME/.config/slim/linux-arch_00391060.png

# Start notification service for screen lock notification
# /usr/lib/notification-daemon-1.0/notification-daemon &

# Setup an autolock
# xautolock -time 30 -locker slimlock  -notify 8 -notifier "zenity --notification --text 'Locking...' --timeout 1" &

# Start dropbox
[[ -d $HOME/.dropbox ]] && dropboxd &
# Start batti
[[ -f /usr/share/applications/batti.desktop ]] && batti &

# Start f.lux to control screen color, remove blue in the evenings
# xflux -z 99201 &

# Simple X hotkey daemon: for custom key chords (also used by bspwm)
# sxhkd &
# Turn off repeating of '/' key so it can be used for chording
# xset -r 34

#set +x# stop debugging from here

# start Window Manager should be last command. This is always running script and end only when X is killed.
#exec xmonad
#exec bspwm #2> ~/.bspwm.log
exec awesome


