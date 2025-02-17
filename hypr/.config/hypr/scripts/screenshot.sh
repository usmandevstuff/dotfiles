#!/bin/bash

INPUT=$1

fullscreen() {
    grimblast save output | xargs -I % notify-send -t 3800 "Screenshot Saved" % -i %
}

area() {
    grimblast save area | xargs -I % notify-send -t 3800 "Screenshot Saved" % -i %
}

case $INPUT in
    "fullscreen") fullscreen
    ;;
    "area") area
    ;;
    *) echo "unknown input"
esac
