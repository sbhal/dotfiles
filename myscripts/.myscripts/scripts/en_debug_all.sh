#!/bin/sh
adb devices
adb shell "
iwpriv wlan0 setwlandbg 0 9 1
iwpriv wlan0 setwlandbg 1 9 1
iwpriv wlan0 setwlandbg 2 9 1
iwpriv wlan0 setwlandbg 3 9 1
iwpriv wlan0 setwlandbg 4 9 1
iwpriv wlan0 setwlandbg 5 9 1
iwpriv wlan0 setwlandbg 6 9 1
iwpriv wlan0 setwlandbg 7 9 1
iwpriv wlan0 setwlandbg 8 9 1
iwpriv wlan0 setwlandbg 9 9 1
iwpriv wlan0 setwlandbg 10 9 1
iwpriv wlan0 setwlandbg 11 9 1
iwpriv wlan0 setwlandbg 12 9 1
"
sleep 2
