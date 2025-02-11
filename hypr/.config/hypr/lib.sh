#!/usr/bin/env bash

cache_theme_path="$HOME/.cache/hyprland_rice/theme"

symlinks=(
    "alacritty:$HOME/.config/alacritty"
    "kitty:$HOME/.config/kitty"
    "rofi:$HOME/.config/rofi"
    "wezterm:$HOME/.config/wezterm"
)

hyprland_version () {
    hyprctl version -j | grep '"tag": ' | sed 's/^ \+//;s/,$//;s/"//g;s/^tag: //;s/^v//'
}

is_tty () {
    [[ "$RICE_TTY_MODE" == 1 ]] && return 0
    [[ "$XDG_SESSION_TYPE" == "tty" ]] && return 0 || return 1
}

is_number () {
    cat /dev/null | head --lines "$1" > /dev/null 2>&1 && return 0 || return 1
}

tty_choose () {
    piped_in="$(cat)"

    prompt="$1"

    message=""
    stop_loop=0

    while [[ "$stop_loop" == 0 ]]; do
        cursor_move_up=0

        line_number=1
        while IFS= read -r line; do
            echo -e "\033[0;36m[\033[0;96m${line_number}\033[0;36m]:\033[0m \033[0;35m${line}\033[0m" >&2
            cursor_move_up=$(( $cursor_move_up + 1 ))
            line_number=$(( $line_number + 1 ))
        done < <(echo "$piped_in")
        line_count=$(( $line_number - 1 ))

        echo " " >&2
        cursor_move_up=$(( $cursor_move_up + 1 ))

        prefix=""
        [[ "$message" == "" ]] || prefix+="[${message}] "

        echo -en "\033[0;33m${prefix}(Choose Number)\033[0m \033[0;93m${prompt}\033[0m" >&2
        read chosen < /dev/tty
        cursor_move_up=$(( $cursor_move_up + 1 ))

        is_valid=0

        if is_number "$chosen"; then
            if [[ "$chosen" -lt 1 ]]; then
                message="Number too low!"
            elif [[ "$chosen" -gt $(( $line_number - 1 )) ]]; then
                message="Number too high!"
            else
                message=""
                is_valid=1
                stop_loop=1
            fi
        else
            message="Please choose a number!"
        fi

        echo -en "\033[${cursor_move_up}A" >&2
        tput ed >&2

        if [[ "$is_valid" == 1 ]]; then
            echo "$piped_in" | head --lines "$chosen" | tail --lines 1
        fi
    done
}

menu_choose () {
    piped_in="$(cat)"

    title="$1"

    prompt="$title"
    [[ "$prompt" == *":" ]] || [[ "$prompt" == *": " ]] || prompt="${prompt}: "
    [[ "$prompt" == *" " ]] || prompt="${prompt} "

    if is_tty; then
        if command -v fzf > /dev/null 2>&1; then
            echo "$piped_in" | fzf --height ~50% --prompt "$prompt" --pointer "->"
        else
            echo "$piped_in" | tty_choose "$prompt"
        fi
    else
        echo "$piped_in" | rofi -dmenu -p "$title"
    fi
}

get_current_wallpaper_path () {
    file_extension="png"

    extension_path="$cache_theme_path/wallpaper_extension.txt"

    if [[ -f "$extension_path" ]]; then
        file_extension="$(cat "$extension_path")"
    fi

    echo "${cache_theme_path}/wallpaper.${file_extension}"
}

set_wallpaper () {
    swww_filter="Lanczos3"
    swww_animation="grow"

    [[ "$2" == "" ]] || swww_filter="$2"
    [[ "$3" == "" ]] || swww_animation="$3"

    echo "Setting wallpaper..."
    echo "Filter: ${swww_filter}"
    echo "Animation: ${swww_animation}"
    echo "Wallpaper Path: '$1'"

	swww img "$1" --filter "$swww_filter" -t "$swww_animation" --transition-pos center || return 1
}

set_wallpaper_themed () {
    wallpaper_animation="$1"
    wallpaper_filter="" # Empty means default. :-)

    wallpaper_info_dir_path="${cache_theme_path}/wallpaper_info"

    if [[ -d "$wallpaper_info_dir_path" ]]; then
        [[ -f "${wallpaper_info_dir_path}/filter" ]] && wallpaper_filter="$(cat "${wallpaper_info_dir_path}/filter")"
    else
        echo "Wallpaper info directory does not exist... assuming defaults..."
    fi

    set_wallpaper "$(get_current_wallpaper_path)" "$wallpaper_filter" "$wallpaper_animation"
}

run_hook () {
    chmod +x "$HOME/.hyprland_rice/autostart_$1"
    $HOME/.hyprland_rice/autostart_$1
}

# eww-rice () {
# 	eww --config ~/.config/eww/ $*
# }

abs_path () {
    new_path="$1"

    home_sed="$(echo "$HOME" | sed 's/\//\\\//g')"

    [[ "$new_path" == "~"* ]] && new_path="$(echo $new_path | sed "s/^~/$home_sed/")"

    echo "$new_path"
}
