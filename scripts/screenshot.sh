#!/bin/bash

area=$(slurp)


grim -g "$area" "/home/andreasbot/Pictures/Screenshots/$(echo screenshot_$(date).png)"

grim -g "$area" - | wl-copy
