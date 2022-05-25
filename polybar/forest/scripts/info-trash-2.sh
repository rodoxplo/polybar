#!/bin/sh

Trash=$(find ~/.local/share/Trash/files/ -maxdepth 1 | wc -l)

if [ "$Trash" = "1" ]; then
   
  echo "%{F#FF0000}%{u#FF0000}%{u-}%{F-}"

else

  echo "%{u#55aa55}$(expr $Trash - 1)%{u-}"

fi
