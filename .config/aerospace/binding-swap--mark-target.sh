#!/bin/bash

STATE="${TMPDIR}aerospace-adlawson-swap"
[ -d "$STATE" ] || mkdir -p "$STATE"

STATE_MARK="${STATE}/mark"
[ -f "$STATE_MARK" ] || touch "$STATE_MARK"

aerospace list-windows --focused --format '%{window-id}' > "$STATE_MARK"

rm -f "${STATE}/prev"
