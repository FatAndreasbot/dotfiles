#!/bin/bash


if [ $(hyprctl monitors | grep "Monitor" | wc -l) = 1 ]; then
    /home/andreasbot/.config/hypr/scripts/1monSetup.sh
else
    /home/andreasbot/.config/hypr/scripts/2monSetup.sh
fi

/home/andreasbot/.config/hypr/scripts/monitorListener.sh
