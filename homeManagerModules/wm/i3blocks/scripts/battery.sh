#!/usr/bin/env sh

. /sys/class/power_supply/BAT0/uevent

if [ "$POWER_SUPPLY_STATUS" = "Charging" ]; then
    icon=""
elif [ "$POWER_SUPPLY_PRESENT" ]; then
    icon=""
elif [ "$POWER_SUPPLY_CAPACITY" -ge 90 ]; then
    icon=""
elif [ "$POWER_SUPPLY_CAPACITY" -ge 70 ]; then
    icon=""
elif [ "$POWER_SUPPLY_CAPACITY" -ge 50 ]; then
    icon=""
elif [ "$POWER_SUPPLY_CAPACITY" -ge 20 ]; then
    icon=""
else
    icon=""
fi

color="#ebdbb2"
if [ "$POWER_SUPPLY_CAPACITY" -le 20 ]; then
    color="#fb4934"
fi

echo "${icon} ${POWER_SUPPLY_CAPACITY}"
echo "${POWER_SUPPLY_CAPACITY}%"
echo "$color"

if [ "$POWER_SUPPLY_CAPACITY" -le 10 ]; then
    exit 33
fi

case "$BLOCK_BUTTON" in
    1) notify-send "Battery Info" "$POWER_SUPPLY_NAME: $POWER_SUPPLY_CAPACITY%" ;;
esac
