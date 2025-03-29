#!/usr/bin/env bash

clamp_min () {
  if [[ "$1" -lt "1" ]]; then
    echo "1"
  else
    echo "$1"
  fi
}

b_mode="$1"

b_factor_step="10"
b_factor=5
# b_factor=$(clamp_min $(($(light | cut -f1 -d .) / $b_factor_step)))
if [[ $b_mode == "up" ]]; then
  brightnessctl set $b_factor%+
elif [[ $b_mode == "down" && $(light | cut -f1 -d .) > 0 ]]; then
  brightnessctl set $b_factor%-
fi

if [[ $(light | cut -f1 -d .) -le 0 ]]; then
  brightnessctl set 1%
fi
