
#!/bin/bash

# Check if Waybar is running
if pgrep waybar > /dev/null; then
    # If running, kill it to hide
    pkill waybar
else
    # If not running, launch Waybar
    waybar &
fi
