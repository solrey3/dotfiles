#!/usr/bin/env bash
set -euo pipefail

# Modern weather widget using wttr.in with secure HTTPS
# Location detection via IP geolocation (more secure than WiFi scanning)

# Configuration
CACHE_FILE="$HOME/.cache/waybar-weather"
CACHE_DURATION=1800  # 30 minutes
TIMEOUT=10           # 10 seconds timeout

# Create cache directory if it doesn't exist
mkdir -p "$(dirname "$CACHE_FILE")"

# Function to get weather data
get_weather() {
    local location=""
    local text tooltip

    # Use IP-based location (more secure than WiFi scanning)
    # wttr.in automatically detects location from IP if no location specified

    # Get weather with timeout and error handling
    if ! text=$(timeout "$TIMEOUT" curl -fsSL "https://wttr.in/?format=1" 2>/dev/null | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | tr -d '\n'); then
        echo '{"text": "󰀦", "tooltip": "Weather unavailable", "class": "weather-error"}'
        return 1
    fi

    # Get detailed tooltip with timeout
    if ! tooltip=$(timeout "$TIMEOUT" curl -fsSL "https://wttr.in/?0QT" 2>/dev/null); then
        tooltip="Weather details unavailable"
    else
        # Properly escape the tooltip for JSON while preserving line breaks
        tooltip=$(echo "$tooltip" | sed 's/\\/\\\\/g; s/"/\\"/g; s/$/\\n/g' | tr -d '\n' | sed 's/\\n$//')
    fi

    # Validate we got actual weather data
    if [[ -z "$text" ]] || [[ "$text" =~ "Unknown location" ]] || [[ "$text" =~ "ERROR" ]]; then
        echo '{"text": "󰀦", "tooltip": "Location not found", "class": "weather-error"}'
        return 1
    fi

    # Output valid JSON
    printf '{"text": "%s", "tooltip": "<tt>%s</tt>", "class": "weather"}\n' "$text" "$tooltip"
}

# Check if cache is still valid
if [[ -f "$CACHE_FILE" ]] && [[ $(($(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0))) -lt $CACHE_DURATION ]]; then
    # Use cached data
    cat "$CACHE_FILE"
else
    # Get fresh weather data and cache it
    if weather_data=$(get_weather); then
        echo "$weather_data" | tee "$CACHE_FILE"
    else
        # If fresh data fails, try to use cached data anyway
        if [[ -f "$CACHE_FILE" ]]; then
            cat "$CACHE_FILE"
        else
            echo '{"text": "󰀦", "tooltip": "Weather service unavailable", "class": "weather-error"}'
        fi
    fi
fi

