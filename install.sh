#!/bin/bash

THISDIR=$(dirname $(readlink -f $0))

function dotfile {
	origen=$1
	destino=$2
	echo "#-----------------------------------------"
	echo "# $destino"
	echo "#-----------------------------------------"
	WARNING="" && [ -f "$destino" ] && WARNING="El actual se sobreescribira!"
	read -p "Instalar $origen en $destino? $WARNING (s/N) " yn
	if [[ $yn =~ ^[YySs]$ ]]; then
		echo ">> $destino - Creando link de $origen a $destino..."
		ln -sf $origen $destino
	else
		echo ">> $destino - no se ha cambiado"
	fi
}

dotfile "$THISDIR/vimrc" "$HOME/.vimrc"
dotfile "$THISDIR/bashrc" "$HOME/.bashrc"
