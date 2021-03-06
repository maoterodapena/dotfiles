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
dotfile "$THISDIR/tmux.conf" "$HOME/.tmux.conf"
which xbindkeys > /dev/null || echo "Ojo: xbindkeys no instalado"
dotfile "$THISDIR/xbindkeysrc" "$HOME/.xbindkeysrc"
dotfile "$THISDIR/bin/move2tile.sh" "$HOME/bin/move2tile.sh"
dotfile "$THISDIR/bin/teclado.sh" "$HOME/bin/teclado.sh"
which vifm > /dev/null || echo "Ojo: vifm no instalado"
dotfile "$THISDIR/vifm" "$HOME/.vifm"

