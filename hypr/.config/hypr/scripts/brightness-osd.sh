#!/bin/bash

min=1   # do not allow below this raw brightness value

case "$1" in
    up)
        brightnessctl set +5%
        ;;
    down)
        current=$(brightnessctl g)
        if [ "$current" -le "$min" ]; then
            brightnessctl set "$min"
        else
            brightnessctl set 5%-
            # re-check in case it still went too low
            current=$(brightnessctl g)
            if [ "$current" -le "$min" ]; then
                brightnessctl set "$min"
            fi
        fi
        ;;
esac

# Get brightness %
brightness=$(brightnessctl g)
max=$(brightnessctl m)
percent=$((brightness * 100 / max))

notify-send -t 800 -h string:x-canonical-private-synchronous:brightness "  Brightness: ${percent}%"
