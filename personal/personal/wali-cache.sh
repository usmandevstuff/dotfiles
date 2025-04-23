#!/usr/bin/env bash

walldir="$HOME/Pictures/walls"
wallcache="$HOME/.cache/wali-cache"

if [ -d "$wallcache" ]; then
    rm -r "$wallcache"
    mkdir -p "$wallcache"
else
    mkdir -p "$wallcache"
fi

notify-send "WALI" "Starting cache process"

for img in "$walldir"/*; do
    magick "$img" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "${wallcache}/$(basename $img)" || notify-send "WALI" "Error: $(basename $img)"
done

notify-send "WALI" "Caching finished successfully"
