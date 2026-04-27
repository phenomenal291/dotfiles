#!/usr/bin/env bash

# Get current profile to display in the prompt
current=$(powerprofilesctl get)

# Define the three standard Linux power states
options="performance\nbalanced\npower-saver"

# Pipe them into your existing Rofi theme
choice=$(echo -e "$options" | rofi -dmenu -p "Power Profile [$current]" -lines 3)

# If a choice is made, apply it and send a system notification
if [ "$choice" ]; then
    powerprofilesctl set "$choice"
    notify-send "Power Profile" "Switched to $choice mode"
fi
