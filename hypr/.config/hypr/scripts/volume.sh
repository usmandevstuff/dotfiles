
#!/bin/bash

INPUT=$1

up() {
    pamixer -i 5
}

down() {
    pamixer -d 5
}

mute() {
    pamixer --toggle-mute
}

case $INPUT in
    "up") up
    ;;
    "down") down
    ;;
    "mute") mute
    ;;
    *) echo "unknown input"
esac
