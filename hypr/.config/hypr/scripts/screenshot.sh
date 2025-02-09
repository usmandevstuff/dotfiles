#!/bin/bash

INPUT=$1

fullscreen() {
    grimblast save output
    notify-send -t 400 "Screenshot Saved"
}

area() {
    grimblast save area
    notify-send -t 400 "Screenshot Saved"
}

case $INPUT in
    "fullscreen") fullscreen
    ;;
    "area") area
    ;;
    *) echo "unknown input"
esac
