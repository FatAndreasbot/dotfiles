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
    data = str(data, encoding='utf-8')[1:-2].split(';')

    if data != "No players found":
        player = data[0].title()
        title = data[1]
        position = data[2]
        lenght = data[3]
        if len(title)>15:
            title = title[0:12]+"..."
        
        if lenght == '':
            out = f"{player} - {title}"
        else:
            out = f"{player} - {title} ({position}/{lenght})"
        

        print(out)
    else:
        print("")
except:
        print("")

