#!/bin/sh
adb devices
adb shell "
iwpriv wlan0 setwlandbg 0 0 1
iwpriv wlan0 setwlandbg 1 0 1
iwpriv wlan0 setwlandbg 2 0 1
iwpriv wlan0 setwlandbg 3 0 1
iwpriv wlan0 setwlandbg 4 0 1
iwpriv wlan0 setwlandbg 5 0 1
iwpriv wlan0 setwlandbg 6 0 1
iwpriv wlan0 setwlandbg 7 0 1
iwpriv wlan0 setwlandbg 8 0 1
iwpriv wlan0 setwlandbg 9 0 1
iwpriv wlan0 setwlandbg 10 0 1
iwpriv wlan0 setwlandbg 11 0 1
iwpriv wlan0 setwlandbg 12 0 1
"
sleep 2
