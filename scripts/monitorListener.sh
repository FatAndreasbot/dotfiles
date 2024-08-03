#!/bin/bash

handle() {
    case $1 in
	monitoradded*) $HOME/.config/hypr/scripts/2monSetup.sh;;
	monitorremoved*) $HOME/.config/hypr/scripts/1monSetup.sh;;
    esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done

	
