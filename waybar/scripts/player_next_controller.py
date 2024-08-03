#!/bin/python

import subprocess as sp

try:
    data = sp.check_output(
        [
            "playerctl", 
            "metadata", 
            "--format",
            '"{{playerName}};{{title}};{{duration(position)}};{{duration(mpris:length)}}"',
            ],
        stderr=sp.DEVNULL,
    )
    data = str(data)[3:-4].split(';')

    if data != "No players found":
        print("")
    else:
        print("")
except:
        print("")
