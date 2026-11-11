#!/bin/sh
I="font_family='Iosevka Nerd Font Mono' size='250%'"

lock="<span $I>󰌾</span>
Bloquear"
suspend="<span $I>󰒲</span>
Suspender"
reboot="<span $I>󰜉</span>
Reiniciar"
shutdown="<span $I>󰐥</span>
Desligar"

choice=$(printf '%s|%s|%s|%s' "$lock" "$suspend" "$reboot" "$shutdown" \
  | rofi -dmenu -sep '|' -markup-rows -format i -no-custom -eh 4 \
         -theme ~/.config/rofi/themes/powermenu.rasi)

case "$choice" in
  0) hyprlock ;;
  1) systemctl suspend ;;
  2) systemctl reboot ;;
  3) systemctl poweroff ;;
esac
