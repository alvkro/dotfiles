#!/usr/bin/env bash
# ============================================================
# weather.sh — módulo custom de clima para o waybar
# Usa wttr.in. Deixe CITY vazio para geolocalização automática
# por IP, ou defina uma cidade fixa (ex: "Fortaleza").
# ============================================================

CITY=""                       # ex: "Fortaleza" — vazio = auto (IP)
CACHE="/tmp/waybar-weather-cache.json"
CACHE_TTL=1800                 # 30 minutos

now=$(date +%s)
if [ -f "$CACHE" ]; then
  mtime=$(stat -c %Y "$CACHE" 2>/dev/null || echo 0)
  if [ $(( now - mtime )) -lt "$CACHE_TTL" ]; then
    cat "$CACHE"
    exit 0
  fi
fi

RAW=$(curl -s --max-time 5 "https://wttr.in/${CITY}?format=%C|%t|%l")

if [ -z "$RAW" ]; then
  echo '{"text":"  --°","tooltip":"Não foi possível obter o clima"}'
  exit 0
fi

COND=$(echo "$RAW"  | cut -d'|' -f1)
TEMP=$(echo "$RAW"  | cut -d'|' -f2 | tr -d ' ')
LOCAL=$(echo "$RAW" | cut -d'|' -f3)

# Escolhe um ícone simples baseado na condição reportada
ICON=""
case "$COND" in
  *Sunny*|*Clear*)                 ICON="" ;;
  *Partly*cloudy*)                 ICON="" ;;
  *Cloudy*|*Overcast*)             ICON="" ;;
  *Rain*|*Drizzle*|*Shower*)       ICON="" ;;
  *Thunder*)                       ICON="" ;;
  *Snow*|*Sleet*|*Ice*)            ICON="" ;;
  *Fog*|*Mist*|*Haze*)             ICON="" ;;
  *)                                ICON="" ;;
esac

TEXT="${ICON}  ${TEMP}"
TOOLTIP="${COND}, ${TEMP}\\n${LOCAL}"

JSON=$(printf '{"text":"%s","tooltip":"%s"}' "$TEXT" "$TOOLTIP")
echo "$JSON" > "$CACHE"
echo "$JSON"
