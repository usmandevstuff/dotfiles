#!/bin/bash
# Usage: osd-notify <icon> <percent>

icon="$1"
value="$2"

ags run "showOSD('$icon', $value)"

