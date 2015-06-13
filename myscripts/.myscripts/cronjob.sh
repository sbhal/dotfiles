#!/bin/sh
cd /local/mnt/workspace/sbhal/kk35; A_EXIT=$?
repo sync -j16 ; B_EXIT=$?
if [ $A_EXIT -eq 0 -a $B_EXIT ]
then
    source build/envsetup.sh;
    lunch msm8974-userdebug;
    make -j16;
    echo "Success" | mail -s "Cron: KK35 Success at $(date +%T)" sbhal@qti.qualcomm.com
fi

cd /local/mnt/workspace/sbhal/master; C_EXIT=$?
repo sync -j16 ; D_EXIT=$?

if [ $C_EXIT -eq 0 -a $D_EXIT ]
then
    echo "Success" | mail -s "Cron: Master Success at $(date +%T)" sbhal@qti.qualcomm.com
fi
