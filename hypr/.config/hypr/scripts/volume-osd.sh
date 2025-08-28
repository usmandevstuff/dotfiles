
#!/bin/bash

# Change volume
case "$1" in
    up)
        # pactl set-sink-volume @DEFAULT_SINK@ +5%
        pamixer -i 5
        ;;
    down)
        # pactl set-sink-volume @DEFAULT_SINK@ -5%
        pamixer -d 5
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
esac

# Get volume and mute state
vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1)
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$mute" = "yes" ]; then
    notify-send -t 800 -h string:x-canonical-private-synchronous:volume "  Muted"
else
    notify-send -t 800 -h string:x-canonical-private-synchronous:volume "  Volume: $vol"
fi
