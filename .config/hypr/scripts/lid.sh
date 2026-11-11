#!/bin/sh
# uso: lid.sh close | open | auto
mode="$1"
echo "$(date +%T) chamado com: $1" >> /tmp/lid.log

if [ "$mode" = "auto" ]; then
  if grep -qi closed /proc/acpi/button/lid/*/state 2>/dev/null; then
    mode=close
  else
    mode=open
  fi
fi

if [ "$mode" = "close" ]; then
  if hyprctl monitors | grep -q "HDMI-A-1"; then
    hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = "1", mirror = "HDMI-A-1" })'
  fi
else
  # reload volta aos monitores definidos no hyprland.lua (estendidos)
  hyprctl reload
fi
