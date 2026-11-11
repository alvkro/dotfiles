#!/bin/sh
out=$(playerctl metadata --format '󰎆  {{artist}} - {{title}}' 2>/dev/null)
[ -n "$out" ] && echo "$out" || echo " "
