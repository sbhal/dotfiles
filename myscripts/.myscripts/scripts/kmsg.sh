#bin/sh
fileno=${1-lazy}
adb wait-for-device root
adb wait-for-device remount
adb shell cat /proc/kmsg | tee >kmsg_$fileno.log >(grep -i -f pattern.txt)  >(grep -i -f pattern.txt > kmsg_grep_$fileno.log)
