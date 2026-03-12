#!/bin/bash

STATE="${TMPDIR}aerospace-adlawson-swap"
[ -d "$STATE" ] || exit 0

STATE_MARK="${STATE}/mark"
STATE_PREV="${STATE}/prev"

# Grab the ID of the window we're currently focused on
target=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null)
[ -n "$target" ] || exit 0

# If we've marked a window the ID should live in `STATE/mark`
[ -f "$STATE_MARK" ] || exit 0
marked=$(head -n 1 "$STATE_MARK")
[ -n "$marked" ] || exit 0

# If `target` and `marked` are the same, swapping is a no-op.
# Attempt to read the previously marked window ID from `STATE/prev`
# to behave like a "toggle".
if [ "$target" == "$marked" ]; then
    [ -f "$STATE_PREV" ] || exit 0
    marked=$(head -n 1 "$STATE_PREV")
    [ -n "$marked" ] || exit 0
    [ "$target" == "$marked"] && exit 0
fi

# Swap the windows.
# Depends on `patch(adlawson)` patched Aerospace.
aerospace swap --window-id "$target" "$marked" 2>/dev/null

# Write the new state
echo "$target" > "$STATE_MARK"
echo "$marked" > "$STATE_PREV"
