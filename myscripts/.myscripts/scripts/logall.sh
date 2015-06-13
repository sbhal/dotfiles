#bin/sh
fileno=${1-lazy}
adb wait-for-device root
adb wait-for-device remount
adb shell '(logcat -v time & cat /proc/kmsg)' | tee >all_$fileno.log >(grep -i -f pattern.txt > all_grep_$fileno.log) >(grep -i -f pattern.txt)
