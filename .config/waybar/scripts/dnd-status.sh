#!/bin/bash
if dunstctl is-paused | grep -q "true"; then
    echo '{"text": "\uf1f6", "tooltip": "Não perturbe: ativado", "class": "dnd-on"}'
else
    echo '{"text": "\uf0f3", "tooltip": "Não perturbe: desativado", "class": "dnd-off"}'
fi
