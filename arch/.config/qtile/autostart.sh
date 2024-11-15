#!/bin/sh

# brightness config and eye saver
brightnessctl set 20%
redshift -0 3500
# wallpaper set
nitrogen --restore
# transparent windows
picom --config ~/.config/picom/picom.conf &
