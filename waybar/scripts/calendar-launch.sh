#!/bin/bash


calendar_running=$(ps a | grep gnome-calendar | wc -l)

if [ $calendar_running = 1 ]; then
	gnome-calendar
else
	killall gnome-calendar
fi
