#!/usr/bin/env bash
# ============================================================
# caffeine.sh — inibe idle/sleep enquanto ativo (usa systemd-inhibit)
# Uso:
#   caffeine.sh          -> imprime o status em JSON (para o "exec" do waybar)
#   caffeine.sh toggle   -> ativa/desativa e avisa o waybar pra redesenhar
# ============================================================

PIDFILE="/tmp/waybar-caffeine.pid"
SIGNAL_NUM=8   # precisa bater com o "signal" no config do waybar

is_active() {
  [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE" 2>/dev/null)" 2>/dev/null
}

toggle() {
  if is_active; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
  else
    systemd-inhibit --what=idle:sleep:handle-lid-switch \
      --who="waybar-caffeine" \
      --why="Ativado manualmente pelo usuário" \
      sleep infinity &
    echo $! > "$PIDFILE"
  fi
  pkill -RTMIN+$SIGNAL_NUM waybar
}

status() {
  if is_active; then
    printf '{"text":"","tooltip":"Caffeine ativo — clique para desativar","class":"active"}'
  else
    printf '{"text":"","tooltip":"Caffeine inativo — clique para ativar","class":"inactive"}'
  fi
}

case "$1" in
  toggle) toggle ;;
  *)      status ;;
esac
