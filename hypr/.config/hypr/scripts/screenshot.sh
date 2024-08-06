#!/usr/bin/env bash

if [[ "$1" == "area" ]]; then
  grimblast save area --cursor || notify-send "Hyprland" "Screenshot aborted."
elif [[ "$1" == "output" ]]; then
  grimblast save output && notify-send "Hyprland" "Screenshot taken."
fi

hyprctl reload
