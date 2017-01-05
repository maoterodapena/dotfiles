#!/bin/bash
# Primero limpio todo

TIMEOUT=200
setxkbmap -option

# Caps se comporta como escape
#setxkbmap es -option ctrl:nocaps -option caps:none -option shift:both_shiftlock -option lv3:ralt_switch
setxkbmap es -option ctrl:nocaps -option caps:none -option lv3:ralt_switch

# Control lanza escape cuando se pulsa y suelta solo
ps -ef | grep "xcape" | grep  "Control_L Escape" | grep -v "grep" > /dev/null
if [ $? -eq 1 ]; then
    xcape -t $TIMEOUT -e 'Control_L=Escape'
    sleep 1
    killall -q -9 apport-gtk 2>/dev/null
#else
    #echo "xcape ya estaba residente"
    #killall -9 xcape
    #xcape -t $TIMEOUT -e 'Control_L=Escape'
fi

# Si se quedan colgadas las mayusculas:
# xdotool key Caps_Lock
