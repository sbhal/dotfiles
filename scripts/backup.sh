#!/bin/bash
echo "        Backup Process started!"
ddot="/home/sbhal/Dropbox/dotfiles/arch"

sdir="/home/sbhal"
ddir="$ddot$sdir"
echo "        $sdir ---> $ddir"
mkdir -vp $ddir
rsync -az $sdir/.xinitrc $ddir/
rsync -az $sdir/.Xresources $ddir/
rsync -az $sdir/.xsession $ddir/
rsync -az $sdir/.xmodmap $ddir/

rsync -az $sdir/.inputrc $ddir/
rsync -az $sdir/.bashrc $ddir/
rsync -az $sdir/.vimrc $ddir/
rsync -az $sdir/.gitconfig $ddir/

rsync -az -r $sdir/.emacs.d $ddir/
rsync -az -r $sdir/.vim $ddir/
rsync -az -r $sdir/.mpd $ddir/
rsync -az -r $sdir/.ncmpcpp $ddir/


sdir="/home/sbhal/.config"
ddir="$ddot$sdir"
echo "        $sdir ---> $ddir"
mkdir -vp $ddir
rsync -az -r $sdir/awesome $ddir/
rsync -az -r $sdir/fontconfig $ddir/


sdir="/etc"
ddir="$ddot$sdir"
echo "        $sdir ---> $ddir"
mkdir -vp $ddir
rsync -az  $sdir/asound.conf $ddir/
rsync -az  $sdir/asound.conf.orig $ddir/
rsync -az  $sdir/bash.bashrc $ddir/
rsync -az  $sdir/bash.bashrc.orig $ddir/
rsync -az  $sdir/DIR_COLORS $ddir/
rsync -az  $sdir/fstab $ddir/
rsync -az  $sdir/locale.conf $ddir/
rsync -az  $sdir/mkinitcpio.custom.conf $ddir/
rsync -az  $sdir/mkinitcpio.conf $ddir/
rsync -az  $sdir/ntp.conf $ddir/
rsync -az  $sdir/pacman.conf $ddir/
rsync -az  $sdir/vconsole.conf $ddir/


sdir="/etc/fonts"
ddir="$ddot$sdir"
echo "        $sdir ---> $ddir"
mkdir -vp $ddir
rsync -az  $sdir/local.conf $ddir/
rsync -az  $sdir/fonts.conf $ddir/


sdir="/etc/X11"
ddir="$ddot$sdir"
echo "        $sdir ---> $ddir"
mkdir -vp $ddir
rsync -az  $sdir/xorg.conf $ddir/
rsync -az -r $sdir/xorg.conf.d $ddir/


sdir="/boot"
ddir="$ddot$sdir"
echo "        $sdir ---> $ddir"
mkdir -vp $ddir
rsync -az -r $sdir/loader $ddir/

sdir="/etc/systemd/system"
ddir="$ddot$sdir"
echo "        $sdir ---> $ddir"
mkdir -vp $ddir
rsync -az -r $sdir $ddir/

sdir="/etc/netctl"
ddir="$ddot$sdir"
echo "        $sdir ---> $ddir"
mkdir -vp $ddir
sudo rsync -az --chmod=604 $sdir/wlp3s0-Bhal $ddir/
sudo rsync -az --chmod=604 $sdir/wlp3s0-Himanshu $ddir/
sudo rsync -az --chmod=604 $sdir/wlp3s0-blizzard $ddir/

echo "        Backup Process Completed!"
sleep 2 
