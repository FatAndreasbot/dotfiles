#!/bin/bash

killall waybar

hyprctl keyword monitor "eDP-1, 1920x1080@60, 0x350, 1"

waybar -c $HOME/.config/waybar/config &
