#!/bin/sh
#
RESV=1080
RESH=1920


HIGHTOPPANEL=24
HIGHWINDOWPANEL=24

X2=$(($RESH/2))

Y2=$((($RESV-$HIGHTOPPANEL)/2+$HIGHTOPPANEL))
SIZEY2=$((($RESV-$HIGHTOPPANEL-$HIGHWINDOWPANEL-$HIGHWINDOWPANEL)/2-2))
SIZEY=$(($RESV-$HIGHTOPPANEL))

DESP=100

xid=`xprop -root _NET_ACTIVE_WINDOW|sed -r 's/.*window id # (0x[0-9a-fA-F]+).*/\1/'`

geometry=`xwininfo -stats -id ${xid}|sed -rn '
	s/ *-geometry *([0-9]+)x([0-9]+)[+-]-?[0-9]+[+-]-?[0-9]+.*/rw=\1 rh=\2/ p;
	s/ *Absolute upper-left X: +([0-9]+)/ax=\1/ p;
	s/ *Relative upper-left X: +([0-9]+)/rx=\1/ p;
	s/ *Absolute upper-left Y: +([0-9]+)/ay=\1/ p;
	s/ *Relative upper-left Y: +([0-9]+)/ry=\1/ p;
	s/ *Width: ([0-9]+)/w=\1/ p;
	s/ *Height: ([0-9]+)/h=\1/ p'`


for value in ${geometry}; do
	case ${value} in
		w=*)
			geo_w=`echo ${value}|cut -d\= -f2`
			;;
		h=*)
			geo_h=`echo ${value}|cut -d\= -f2`
			;;
		rw=*)
			geo_rw=`echo ${value}|cut -d\= -f2`
			;;
		rh=*)
			geo_rh=`echo ${value}|cut -d\= -f2`
			;;
		ax=*)
			geo_ax=`echo ${value}|cut -d\= -f2`
			;;
		rx=*)
			geo_rx=`echo ${value}|cut -d\= -f2`
			;;
		ay=*)
			geo_ay=`echo ${value}|cut -d\= -f2`
			;;
		ry=*)
			geo_ry=`echo ${value}|cut -d\= -f2`
			;;
	esac
done

geo_x=$((${geo_ax}-${geo_rx}))
geo_y=$((${geo_ay}-${geo_ry}))

# 0            960,0          1920,0
#
#
#
# 0,552        960,504        1920,504
#
# 0,5j

file_touch="/tmp/_tiles_$xid-$1"
TILE_ANTERIOR=`echo $(ls /tmp/_tiles_$xid* | cut -b 23)`

if [ -e $file_touch ]; then
    MISMOTILE=1
else
    rm /tmp/_tiles_$xid-*
    touch $file_touch
    MISMOTILE=0
fi

case $1 in
    '7')
        NX=0; NY=0; NW=$(($X2-1)); NH=$SIZEY2
       ;;
    '1')
       NX=0; NY=$Y2; NW=$(($X2-1)); NH=$SIZEY2
       ;;
    '9')
       NX=$X2; NY=0; NW=$(($X2-1)); NH=$SIZEY2
       ;;
    '3')
       NX=$X2; NY=$Y2; NW=$(($X2-1)); NH=$SIZEY2
       ;;
    '4')
       if [ $TILE_ANTERIOR -eq 6 ]; then
            NX=$(($X2-$DESP)); NY=0; NW=$(($X2-1+$DESP)); NH=$(($SIZEY-HIGHTOPPANEL-3))
            rm /tmp/_tiles_$xid-*
       else
            NX=0; NY=0; NW=$(($X2-1)); NH=$(($SIZEY-HIGHTOPPANEL-3))
       fi

       ;;
    '6')
#        wmctrl -r :ACTIVE: -e "0,$X2,0,$(($X2-1)),$SIZEY" # borde derecho
        if [ $TILE_ANTERIOR -eq 4 ]; then
            NX=0; NY=0; NW=$(($X2-1+DESP)); NH=$(($SIZEY-HIGHTOPPANEL-3))
            rm /tmp/_tiles_$xid-*
        else
            NX=$X2; NY=0; NW=$(($X2-1)); NH=$(($SIZEY-HIGHTOPPANEL-3))
        fi
       ;;
    '8')
        # MAXIMIZAR/RESTAURAR
        wmctrl -r :ACTIVE: -b toggle,maximized_vert,maximized_horz
        exit 0
        ;;
    '5')
        # ECHAR ATRAS
        wmctrl -r :ACTIVE: -b toggle,below
        exit 0

esac

casiigual () { 

    if [ $1 -gt $2 -a $(($1-$2)) -lt 5 ] || [ $2 -ge $1 -a $(($2-$1)) -lt 5 ]
    then
        echo 1
    else
        echo 0
    fi
}

echo "$geo_ax-$NX : $NY-$(($geo_ay-$HIGHTOPPANEL-$HIGHWINDOWPANEL))"
if [ $(casiigual $geo_ax $NX) -eq 1 -a $(casiigual $NY $(($geo_ay-$HIGHTOPPANEL-$HIGHWINDOWPANEL))) -eq 1 ]
then
    echo "todo igual"
fi
wmctrl -r :ACTIVE: -e "0,$NX,$NY,$NW,$NH"
wmctrl -r :ACTIVE: -e "0,$NX,$NY,$NW,$NH"
wmctrl -r :ACTIVE: -e "0,$NX,$NY,$NW,$NH"
echo "wmctrl -r :ACTIVE -e 0,$NX,$NY,$NW,$NH"
echo $(casiigual $geo_ax $NX)

echo $geometry
