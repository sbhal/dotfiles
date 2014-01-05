#!/bin/bash
## Script to call backup.sh
echo "        Do you want to BackUp your System now ? (y/n) : "
read now
case "$now" in
    [nN]*) echo "        BackUp Cancelled!" ;;
    [yY]*) /home/sbhal/Dropbox/dotfiles/scripts/backup.sh ;;
        *) echo "        BackUp Terminated by default! Bad option!" 
esac
