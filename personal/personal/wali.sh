#!/usr/bin/env bash

wallcache="$HOME/.cache/wali-cache"
walldir="$HOME/Pictures/walls"


IFS=$'\n'

font_scale="${ROFI_WALLPAPER_SCALE}"
    [[ "${font_scale}" =~ ^[0-9]+$ ]] || font_scale=${ROFI_SCALE:-10}

font_override="* {font: \"${font_name:-"JetBrainsMono Nerd Font"} ${font_scale}\";}"

mon_data=$(hyprctl -j monitors)
    mon_x_res=$(jq '.[] | select(.focused==true) | if (.transform % 2 == 0) then .width else .height end' <<<"${mon_data}")
    mon_scale=$(jq '.[] | select(.focused==true) | .scale' <<<"${mon_data}" | sed "s/\.//")
    mon_x_res=$((mon_x_res * 100 / mon_scale))

    #// generate config

    elm_width=$(((24 + 8 + 5) * font_scale))
    max_avail=$((mon_x_res - (4 * font_scale)))
    col_count=$((max_avail / elm_width))


r_override="window{width:100%;}
    listview{columns:${col_count};spacing:5em;}
    element{border-radius:6px;
    orientation:vertical;} 
    element-icon{size:24em;border-radius:0em;}
    element-text{padding:1em;}"


# grab the user selected wallpaper
SELECTED_WALL=$(for a in $wallcache/*; do echo -en "$(basename $a)\0icon\x1f$wallcache/$(basename $a)\n" ; done | rofi -dmenu \
            -display-column-separator ":::" \
            -display-columns 1 \
            -theme-str "${font_override}" \
            -theme-str "${r_override}" \
            -theme "~/.config/rofi/selector")

if [ -n "$SELECTED_WALL" ]; then
    swww img "$walldir/$SELECTED_WALL" --transition-type wave --transition-fps 60
fi
