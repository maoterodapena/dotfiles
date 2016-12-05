#!/bin/bash

TITULO=$(zenity --text="Nuevo titulo de ventana?" --title="Input" --entry)
wmctrl -r :SELECT: -N $TITULO
