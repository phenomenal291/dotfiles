#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Declare an associative array to keep track of screen coordinates
declare -A coords

# Read through every connected monitor
while read -r line; do
    # Extract the monitor name (e.g., eDP-1, HDMI-1)
    m=$(echo "$line" | cut -d" " -f1)

    # Extract the geometry math (e.g., 1920x1080+0+0)
    geom=$(echo "$line" | grep -oE "[0-9]+x[0-9]+\+[0-9]+\+[0-9]+")

    # If the monitor is active (has geometry)
    if [ -n "$geom" ]; then
        # Check if we have already drawn a bar at these exact coordinates
        if [ -z "${coords[$geom]}" ]; then
            # Coordinate is empty, launch the bar!
            MONITOR=$m polybar --reload main &
            # Mark this coordinate as occupied
            coords[$geom]=1
        fi
    fi
done <<< "$(xrandr --query | grep " connected")"
