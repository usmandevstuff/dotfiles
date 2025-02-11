#!/usr/bin/env bash

source ~/.config/hypr/lib.sh

notify_name="Theme Chooser"

cache_theme_path="$HOME/.cache/hyprland_rice/theme"
cache_theme_list_path="$HOME/.cache/hyprland_rice/theme_list.txt"
wallpaper_info_dir_path="${cache_theme_path}/wallpaper_info"

#while IFS= read -r i; do
#  echo "$i"
#done < $HOME/.hyprland_rice/themes.txt

rm ~/.cache/hyprland_rice/theme_list.txt > /dev/null 2>&1

if [[ "$1" == "" ]]; then
  theme_categ=$(echo -e "All\nBuilt-In\nExtra Built-In\nCustom" | menu_choose " 󰉼  Categories ")
  
  echo "Chosen Category: '${theme_categ}'"
  
  if [[ $theme_categ == "All" ]]; then
    cat $HOME/.config/hypr/themes/themes.txt $HOME/.config/hypr/extra_themes/themes.txt $HOME/.hyprland_rice/themes.txt > $cache_theme_list_path
  elif [[ $theme_categ == "Built-In" ]]; then
    cat $HOME/.config/hypr/themes/themes.txt > $cache_theme_list_path
  elif [[ $theme_categ == "Extra Built-In" ]]; then
    cat $HOME/.config/hypr/extra_themes/themes.txt > $cache_theme_list_path
  elif [[ $theme_categ == "Custom" ]]; then
    cat $HOME/.hyprland_rice/themes.txt > $cache_theme_list_path
  else
    echo "Invalid category."
    exit 1
  fi
fi

key_to_value () {
  cat "$1" | grep "\$$2 ->" | sed 's/\$//g' | awk -F ' -> ' '{ print $2 }' | sed 's/;//g'
}

theme_path=""

if [[ "$1" == "" ]]; then
  chosen_theme="$(cat $cache_theme_list_path | sed 's/\$//g' | awk -F ' -> ' '{ print $1 }' | menu_choose " 󰉼  Themes ")"
  
  theme_path="$(key_to_value "$cache_theme_list_path" "$chosen_theme")"
  theme_path="$(abs_path "$theme_path")"
else
  theme_path="$1"
fi

notify-send "$notify_name" "Setting theme... please wait..."

rm -rf "$cache_theme_path" > /dev/null 2>&1
cp -r "$theme_path" "$cache_theme_path"
mkdir -p "$wallpaper_info_dir_path"

echo \
"Once the theme is copied into this cache theme,
the cache theme may get modified post-copy." \
> "$cache_theme_path/DISCLAIMER.txt"

if [[ -f "$cache_theme_path/wallpaper.png" ]]; then
    echo "Using wallpaper provided at theme root..."
else
    if [[ -f "$cache_theme_path/wallpapers/list.txt" ]]; then
        wallpapers_list_path="$cache_theme_path/wallpapers/list.txt"

        chosen_wallpaper="$(cat "$wallpapers_list_path" | sed 's/\$//g' | awk -F ' -> ' '{ print $1 }' | menu_choose " 󰲍  Wallpapers ")"

        wallpaper_extension="png"

        chosen_value="$(key_to_value "$wallpapers_list_path" "$chosen_wallpaper")"

        wallpapers_path="${cache_theme_path}/wallpapers"

        found_extension="$(echo "$chosen_value" | awk -F '.' '{ print $2 }')"

        [[ "$found_extension" == "" ]] || wallpaper_extension="$found_extension"
        chosen_value="$(echo "$chosen_value" | awk -F '.' '{ print $1 }')" # Kind of a hack. :-\

        echo "$wallpaper_extension" > "${cache_theme_path}/wallpaper_extension.txt"

        echo "Wallpaper File Extension: '.${wallpaper_extension}'"

        wallpaper_path="${cache_theme_path}/wallpapers/${chosen_value}.${wallpaper_extension}"
        wallpaper_info_path="${wallpaper_path}.txt"

        wallpaper_filter="$(key_to_value "$wallpaper_info_path" "filter" 2> /dev/null)"

        echo "$wallpaper_filter" > "${wallpaper_info_dir_path}/filter"

        echo "Chosen Wallpaper: '${chosen_wallpaper}'"

        if [[ -f "$wallpaper_path" ]]; then
            cp "$wallpaper_path" "$cache_theme_path/wallpaper.${wallpaper_extension}" || notify-send -u critical "$notify_name" "Failed to copy over wallpaper!"
        else
            notify-send -u critical "$notify_name" "The given wallpaper value once expanded into a file path does not exist at that path! Expanded path: '${wallpaper_path}'"
        fi
    else
        echo "Failed to find valid wallpaper!"
    fi
fi

rm ~/.cache/hyprland_rice/theme_path.txt > /dev/null 2>&1
echo "$theme_path" > ~/.cache/hyprland_rice/theme_path.txt

rm ~/.cache/hyprland_rice/theme_refresh_id.txt > /dev/null 2>&1

if [[ -f ~/.config/hypr/templates/refresh_id ]]; then
  cp ~/.config/hypr/templates/refresh_id ~/.cache/hyprland_rice/theme_refresh_id.txt
else
  echo 'null' > ~/.cache/hyprland_rice/theme_refresh_id.txt
fi

HYPRCTL_FLAGS=""

hyprctl reload > /dev/null 2>&1 || HYPRCTL_FLAGS+="--instance 0"

hyprctl ${HYPRCTL_FLAGS} dispatch exec ~/.config/hypr/scripts/refresh_theme.sh
# hyprctl ${HYPRCTL_FLAGS} dispatch exec ~/.config/hypr/scripts/refresh_after_theme_change.sh

notify-send "$notify_name" "Set theme! Enjoy! <3"
