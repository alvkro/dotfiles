#!/bin/sh
cap=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
[ -n "$cap" ] && echo "󰁹  ${cap}%" || echo " "
