#!/usr/bin/env bash

brightness=$(light | cut -f1 -d .)

if [[ $brightness -le 1 ]]; then
  brightnessctl set 100%
else
  brightnessctl set 1%
fi
