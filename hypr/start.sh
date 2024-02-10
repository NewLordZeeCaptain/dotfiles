#!/usr/bin/env bash 

# Wallpaper
hyprpaper -c ~/.config/hypr/hyprpaper.conf &

# NetworkManager applet
nm-applet --indicator &

# Waybar
waybar &

# dunst
dunst
