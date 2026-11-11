#!/bin/bash
FILE=~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png
grim -g "$(slurp)" "$FILE"
wl-copy < "$FILE"
