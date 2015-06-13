#!/bin/sh
adb devices
fastboot flash boot boot.img
fastboot flash system system.img
fastboot flash userdata userdata.img
fastboot flash persist persist.img
fastboot flash recovery recovery.img
fastboot flash cache cache.img
#fastboot flash tombstones tombstones

fastboot boot boot.img
sleep 2
