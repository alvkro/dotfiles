hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@75",
    position = "0x0",
    scale    = "1",
})

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "1920x0",
    scale    = "1",
})
EOFcat > ~/.config/hypr/monitors.lua << 'EOF'
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@75",
    position = "0x0",
    scale    = "1",
})

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "1920x0",
    scale    = "1",
})
