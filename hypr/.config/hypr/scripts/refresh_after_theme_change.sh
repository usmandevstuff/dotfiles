
#!/usr/bin/env bash

source ~/.config/hypr/lib.sh

swaync-client -rs > /dev/null 2>&1

notify-send "Reloading Waybar"

killall -SIGUSR2 waybar > /dev/null 2>&1 # Reload waybar
# ~/.config/hypr/waybar/start > /dev/null 2>&1
# ~/.config/hypr/eww/start > /dev/null 2>&1

set_wallpaper_themed

hyprctl reload > /dev/null
