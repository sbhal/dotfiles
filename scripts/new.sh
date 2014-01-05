echo " New script"
ddotfiles="/home/sbhal/Dropbox/dotfiles"
sdir="/etc/fonts"
ddir="$ddotfiles$sdir"
echo $ddir
mkdir -vp $ddir
rsync  $sdir/local.conf $ddir/
echo " Process completed script"
