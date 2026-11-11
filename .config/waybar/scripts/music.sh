#!/usr/bin/env bash
# ============================================================
# music.sh — modulo custom de musica para o waybar
# Requer: playerctl (funciona com Spotify, MPV, Firefox, etc.)
# CORRIGIDO: icone de play/pause estava invertido
# ============================================================

MAXLEN=40

if ! command -v playerctl &>/dev/null; then
  echo '{"text":"","tooltip":"playerctl não instalado","class":"none"}'
  exit 0
fi

STATUS=$(playerctl status 2>/dev/null)

if [ -z "$STATUS" ]; then
  echo '{"text":"","tooltip":"Nenhuma música tocando","class":"none"}'
  exit 0
fi

ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)

case "$STATUS" in
  Playing) ICON="" ;;
  Paused)  ICON="" ;;
  *)       ICON="" ;;
esac

if [ -n "$ARTIST" ]; then
  RAW_TEXT="${ARTIST} - ${TITLE}"
else
  RAW_TEXT="${TITLE}"
fi

if [ ${#RAW_TEXT} -gt $MAXLEN ]; then
  RAW_TEXT="${RAW_TEXT:0:$MAXLEN}…"
fi

ESC_TEXT=$(echo "$RAW_TEXT" | sed 's/"/\\"/g')
ESC_TOOLTIP=$(echo "${ARTIST} - ${TITLE}" | sed 's/"/\\"/g')
CLASS=$(echo "$STATUS" | tr '[:upper:]' '[:lower:]')

printf '{"text":"%s %s","tooltip":"%s","class":"%s"}' "$ICON" "$ESC_TEXT" "$ESC_TOOLTIP" "$CLASS"
