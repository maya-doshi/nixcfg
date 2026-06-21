#!/usr/bin/env sh

case "$BLOCK_BUTTON" in
    1) pwvucontrol > /dev/null 2>&1 & disown ;;     # left click
    3) blueman-manager > /dev/null 2>&1 & disown ;; # right click
esac

if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"; then
    final=" "
else
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1 | tr -d '%')

    if [ "$volume" -ge 70 ]; then
        icon=""
    elif [ "$volume" -ge 10 ]; then
        icon=""
    else
        icon=""
    fi
    final="${icon} ${volume}"
fi

echo "${final}"
