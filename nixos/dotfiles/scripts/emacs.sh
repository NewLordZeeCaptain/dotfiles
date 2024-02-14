#!/usr/bin/env bash
DOOM="$HOME/.config/emacs"

if [ ! -d "$DOOM" ]; then
	git clone https://github.com/hlissner/doom-emacs.git $DOOM
	$DOOM/bin/doom -y install
fi

$DOOM/bin/doom sync
