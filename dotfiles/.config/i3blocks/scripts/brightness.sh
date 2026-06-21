#!/usr/bin/env sh

brightness=$(brightnessctl g)
max_brightness=$(brightnessctl m)
percent=$(( 100 * brightness / max_brightness ))

if [ "$percent" -ge 80 ]; then
    icon="󰃚"
elif [ "$percent" -ge 30 ]; then
    icon="󰃛"
else
    icon="󰃜"
fi

color="#8ec07c"

echo "${icon} ${percent}"

case "$BLOCK_BUTTON" in
    1) notify-send "Brightness" "$(brightnessctl info | grep -E 'Current brightness|Max brightness')" ;;  # left click
esac
