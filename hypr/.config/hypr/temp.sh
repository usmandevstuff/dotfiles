!#/usr/bin/env bash
#!/bin/bash

case "$1" in
    up)
        brightnessctl set +5%
        ;;
    down)
        brightnessctl set 5%-
        ;;
esac

# Get brightness %
brightness=$(brightnessctl g)
max=$(brightnessctl m)
percent=$((brightness * 100 / max))

notify-send -t 800 -h string:x-canonical-private-synchronous:brightness "☀️ Brightness: ${percent}%"


