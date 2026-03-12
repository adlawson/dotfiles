#!/bin/bash

# Get the focused window's ID, bundle ID, and layout
focused=$(aerospace list-windows --focused --format '%{window-id} %{app-bundle-id} %{window-parent-container-layout}' 2>/dev/null)
focused_id=$(echo "$focused" | awk '{print $1}')
focused_bundle=$(echo "$focused" | awk '{print $2}')
focused_layout=$(echo "$focused" | awk '{print $3}')

# Only act on Ghostty windows
if [ "$focused_bundle" != "com.mitchellh.ghostty" ]; then
    exit 0
fi

# If the focused window is already tiled, nothing to do
if [ "$focused_layout" != "floating" ]; then
    exit 0
fi

# Find the first tiled Ghostty window that isn't the focused window (Window B)
tiled_id=$(aerospace list-windows --all --format '%{window-id} %{app-bundle-id} %{window-parent-container-layout}' 2>/dev/null \
    | awk -v focused="$focused_id" '$2 == "com.mitchellh.ghostty" && $3 != "floating" && $1 != focused {print $1; exit}')

# If no tiled Ghostty window exists, nothing to swap with
[ -n "$tiled_id" ] || exit 0

# Swap Window A (focused) with Window B (tiled)
# Depends on `patch(adlawson)` patched Aerospace
aerospace swap --window-id "$focused_id" "$tiled_id" 2>/dev/null
