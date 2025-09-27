#!/usr/bin/env bash
set -euo pipefail

# Brightness control and display for waybar

# Function to get current brightness
get_brightness() {
    local brightness_file
    local max_brightness_file
    local current max percentage

    # Find brightness control files
    for backlight_dir in /sys/class/backlight/*; do
        if [[ -d "$backlight_dir" ]]; then
            brightness_file="$backlight_dir/brightness"
            max_brightness_file="$backlight_dir/max_brightness"

            if [[ -f "$brightness_file" ]] && [[ -f "$max_brightness_file" ]]; then
                current=$(cat "$brightness_file" 2>/dev/null || echo 0)
                max=$(cat "$max_brightness_file" 2>/dev/null || echo 1)

                if [[ "$max" -gt 0 ]]; then
                    percentage=$(( (current * 100) / max ))
                    printf '{"text":"☀ %d%%", "tooltip":"Brightness: %d%%"}\n' "$percentage" "$percentage"
                    return 0
                fi
            fi
        fi
    done

    # Fallback: no brightness control found
    printf '{"text":"☀ N/A", "tooltip":"Brightness control not available"}\n'
}

get_brightness
