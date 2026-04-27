#!/usr/bin/env bash

#!/usr/bin/env bash

# 1. Grab every connected screen on the machine
ALL_SCREENS=$(xrandr | grep " connected" | cut -d" " -f1)

# 2. Identify the laptop screen (looks for eDP/LVDS, falls back to the first screen listed)
LAPTOP=$(echo "$ALL_SCREENS" | grep -E "eDP|LVDS" | head -n 1)
if [ -z "$LAPTOP" ]; then
    LAPTOP=$(echo "$ALL_SCREENS" | head -n 1)
fi

# 3. Identify the external screen by strictly subtracting the laptop screen from the list
EXTERNAL=$(echo "$ALL_SCREENS" | grep -v "$LAPTOP" | head -n 1)

# Safety check: If subtraction leaves us with nothing, it means you unplugged the HDMI
if [ -z "$EXTERNAL" ]; then
    xrandr --output "$LAPTOP" --auto
    notify-send "Display" "No external monitor detected."
    i3-msg restart
    exit 0
fi

# 4. Define the menu options
options="💻 Laptop Only\n🖥️ External Only\n👯 Duplicate\n➡️ Extend (Right)"

# 5. Pipe options into Rofi
choice=$(echo -e "$options" | rofi -dmenu -i -p "Display Setup" -lines 4)

# 6. Execute the correct layout
case "$choice" in
    "💻 Laptop Only")
        xrandr --output "$LAPTOP" --auto --output "$EXTERNAL" --off
        ;;
    "🖥️ External Only")
        xrandr --output "$LAPTOP" --off --output "$EXTERNAL" --auto
        ;;
    "👯 Duplicate")
        xrandr --output "$LAPTOP" --auto --output "$EXTERNAL" --auto --same-as "$LAPTOP"
        ;;
    "➡️ Extend (Right)")
        xrandr --output "$LAPTOP" --auto --output "$EXTERNAL" --auto --right-of "$LAPTOP"
        ;;
    *)
        exit 0
        ;;
esac

# 7. Restart i3
i3-msg restart

# If no external monitor is plugged in, default to laptop and exit
if [ -z "$EXTERNAL" ]; then
    xrandr --output "$LAPTOP" --auto
    notify-send "Display" "No external monitor detected."
    i3-msg restart
    exit 0
fi

# 2. Define the menu options
options="💻 Laptop Only\n🖥️ External Only\n👯 Duplicate\n➡️ Extend (Right)"

# 3. Pipe options into Rofi
choice=$(echo -e "$options" | rofi -dmenu -i -p "Display Setup" -lines 4)

# 4. Execute the correct xrandr layout based on selection
case "$choice" in
    "💻 Laptop Only")
        xrandr --output "$LAPTOP" --auto --output "$EXTERNAL" --off
        ;;
    "🖥️ External Only")
        xrandr --output "$LAPTOP" --off --output "$EXTERNAL" --auto
        ;;
    "👯 Duplicate")
        xrandr --output "$LAPTOP" --auto --output "$EXTERNAL" --auto --same-as "$LAPTOP"
        ;;
    "➡️ Extend (Right)")
        xrandr --output "$LAPTOP" --auto --output "$EXTERNAL" --auto --right-of "$LAPTOP"
        ;;
    *)
        exit 0
        ;;
esac

# 5. Restart i3 to fix stranded workspaces and reset Polybar instances
i3-msg restart
