#!/bin/bash
# Primero limpio todo
setxkbmap -option

# Caps se comporta como escape
#setxkbmap es -option ctrl:nocaps -option caps:none -option shift:both_shiftlock -option lv3:ralt_switch
setxkbmap es -option ctrl:nocaps -option caps:none -option lv3:ralt_switch

# Control lanza escape cuando se pulsa y suelta solo
ps -ef | grep "xcape -e Control_L Escape" | grep -v "grep" > /dev/null
if [ $? -eq 1 ]; then
    xcape -e 'Control_L=Escape'
else
    echo "xcape ya estaba residente"
    killall -9 xcape
    xcape -e 'Control_L=Escape'
fi
sleep 1
killall -9 apport-gtk 2>/dev/null

