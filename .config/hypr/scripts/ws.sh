#!/bin/sh
# uso: ws.sh go|move N   (N de 1 a 5)
action="$1"; n="$2"

mon=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
count=$(hyprctl monitors -j | jq 'length')

# com 2 monitores, o notebook usa 6-10
if [ "$mon" = "eDP-1" ] && [ "$count" -gt 1 ]; then
  n=$((n + 5))
fi

if [ "$action" = "move" ]; then
  hyprctl dispatch "hl.dsp.window.move({ workspace = $n })"
else
  hyprctl dispatch "hl.dsp.focus({ workspace = $n })"
fi
