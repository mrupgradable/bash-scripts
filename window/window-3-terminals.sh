#!/bin/bash

# Launch three terminal windows
#gnome-terminal &
#gnome-terminal &
#gnome-terminal &

# Give some time for terminals to launch
sleep 2

# Get the window IDs of the terminal windows
terminal_windows=$(wmctrl -l | grep "Terminal" | awk '{print $1}')

echo "Terminal Windows"
echo "$terminal_windows"

# Get monitor geometries
monitor_geometries=$(xrandr | grep " connected" | awk '{print $1, $3}')

echo "Geometries"
echo "$monitor_geometries"


echo "Something more!"

# Convert monitor geometries to an array
IFS=$'\n' read -rd '' -a monitors <<<"$monitor_geometries"

# Convert terminal window IDs to an array
IFS=$'\n' read -rd '' -a windows <<<"$terminal_windows"

# Iterate over the windows and assign them to monitors
for i in "${!windows[@]}"; do
    # Extract monitor name and geometry
    monitor_name=$(echo "${monitors[i]}" | awk '{print $1}')
    geometry=$(echo "${monitors[i]}" | awk '{print $2}')

    echo "it-ing window monitor-name:${monitor_name} geometry:${geometry}"

    # Extract offset (X and Y positions)
    offset_x=$(echo "$geometry" | cut -d'+' -f2)
    offset_y=$(echo "$geometry" | cut -d'+' -f3)

    echo "offsets x:${offset_x} y:${offset_y}"

    # Move the window to the specified monitor
    wmctrl -i -r "${windows[i]}" -e "0,$offset_x,$offset_y,-1,-1"
done


for_window [app_id="gnome-terminal"] move to workspace 1
for_window [app_id="gnome-terminal"] move to workspace 2
for_window [app_id="gnome-terminal"] move to workspace 3

