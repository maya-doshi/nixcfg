#!/usr/bin/env sh

info=$(acpi -b)
percent=$(echo "$info" | grep -oP '[0-9]+(?=%)')
status=$(echo "$info" | awk '{print $3}' | tr -d ',')

if [[ "$status" == "Charging" ]]; then
    icon=""
elif [[ "$status" == "Not" ]]; then
    icon=""
elif [ "$percent" -ge 90 ]; then
    icon=""
elif [ "$percent" -ge 70 ]; then
    icon=""
elif [ "$percent" -ge 50 ]; then
    icon=""
elif [ "$percent" -ge 20 ]; then
    icon=""
else
    icon=""
fi

color="#ebdbb2"
if [ "$percent" -le 20 ]; then
    color="#fb4934"
fi

echo "${icon} ${percent}"
echo "${percent}%"
echo "$color"

if [ "$percent" -le 10 ]; then
    exit 33
fi

case "$BLOCK_BUTTON" in
    1) notify-send "Battery Info" "$(acpi -b)" ;;
esac
