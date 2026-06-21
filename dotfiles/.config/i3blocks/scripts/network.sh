#!/usr/bin/env sh

if ip link show | grep "enp" | grep -q "state UP" ; then
    echo "󰈀 Up"
else
    # Check for a Wi-Fi connection
    SSID=$(iwgetid -r)
    if [ -n "$SSID" ]; then
        echo "󰤨 $SSID"
    else
        echo "󰤭 "
    fi
fi
