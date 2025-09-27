#!/usr/bin/env bash
set -euo pipefail

# Battery power draw indicator for waybar

powerDraw=""

# Find the first available battery
for bat_path in /sys/class/power_supply/BAT*; do
    if [[ -d "$bat_path" ]] && [[ -f "$bat_path/power_now" ]]; then
        if power_now=$(cat "$bat_path/power_now" 2>/dev/null); then
            # Convert microwatts to watts
            power_watts=$((power_now / 1000000))
            powerDraw="󰠰 ${power_watts}W"
            break
        fi
    fi
done

# If no power draw available, check if we're on AC power
if [[ -z "$powerDraw" ]]; then
    for ac_path in /sys/class/power_supply/A{C,DP}*; do
        if [[ -f "$ac_path/online" ]] && [[ $(cat "$ac_path/online" 2>/dev/null || echo 0) == "1" ]]; then
            powerDraw="🔌 AC"
            break
        fi
    done
fi

# Default fallback
if [[ -z "$powerDraw" ]]; then
    powerDraw="⚡ N/A"
fi

printf '{"text":"%s", "tooltip":"Power: %s"}\n' "$powerDraw" "$powerDraw"
