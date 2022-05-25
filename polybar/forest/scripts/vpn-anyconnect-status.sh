#!/bin/sh

IFACE=$(ip a | grep tun | awk '{print $2}' | cut -f1 -d ':' | cut -f3 -d '/')
IFACE2=$(ip a | grep tun | awk '{print $2}' | cut -f1 -d ':' | cut -f3 -d '/')

if [ "$IFACE" = "tun0" ]; then
    echo "%{u#55aa55}$(ip a show tun0 | grep inet | awk '{print $2}' | cut -f2 -d ':' | cut -f1 -d '/')%{u-}"


elif [ "$IFACE2" = "vpn0" ]; then
    echo "%{u#55aa55}$(ip a show vpn0 | grep inet | awk '{print $2}' | cut -f2 -d ':' | cut -f1 -d '/')%{u-}"

  else
    #echo "%{F#FF0000}%{u#FF0000}None%{u-}%{F-}"
    echo "%{F#FF0000}%{u#FF0000}%{u-}%{F-}"
fi
