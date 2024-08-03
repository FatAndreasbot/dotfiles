#!/bin/bash

killall waybar

hyprctl keyword monitor "eDP-1, 1920x1080@60, 0x525, 1.5"
hyprctl keyword monitor "HDMI-A-1, 1920x1080@75, auto, 1"

waybar -c $HOME/.config/waybar/config_2 &
waybar -c $HOME/.config/waybar/config_3 &
