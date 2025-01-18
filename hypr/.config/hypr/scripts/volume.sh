
#!/bin/bash

INPUT=$1

up() {
    pamixer -i 5
}

down() {
    pamixer -d 5
}

case $INPUT in
    "up") up
    ;;
    "down") down
    ;;
    *) echo "unknown input"
esac
