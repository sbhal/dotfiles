#bin/sh
fileno=${1-lazy}
grep1=${2-wlan}
grep2=${3-wcnss}
grep3=${4-vishu}
grep4=${5-subsys-restart}
grep5=${6-PRONTO}
grep6=${7-vishu}
grep7=${8-ASSERT}
grep8=${9-<1>}
grep9=${10-<2>}
grep10=${11-driver loaded}
adb wait-for-device root
adb wait-for-device remount
adb shell cat /proc/kmsg | tee >kmsg_$fileno.log >(grep -i "$grep1\|$grep2\|$grep3\|$grep4\|$grep5\|$grep6\|$grep7\|$grep8\|$grep9\|$grep10")
