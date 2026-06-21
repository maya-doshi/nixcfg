#!/usr/bin/env sh

max_width=40

case "$BLOCK_BUTTON" in
    1) playerctl play-pause ;;   # left click
    3) playerctl next && sleep 0.25;;         # right click
    4) playerctl previous && sleep 0.25;;     # scroll up
    5) playerctl next && sleep 0.25;;         # scroll down
esac

# artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)
status=$(playerctl status 2>/dev/null)

if [[ -z "$artist" && -z "$title" ]]; then
    exit 0
fi

if [[ "$status" == "Playing" ]]; then
    icon=""
elif [[ "$status" == "Paused" ]]; then
    icon=""
else
    icon=""
fi

# full_text="$artist - $title"
#
# length=${#full_text}
#
# if (( length > max_width )); then
#     display_text="$title"
# else
#     display_text="$full_text"
# fi

echo "$icon $title"
