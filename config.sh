#!/bin/sh

for f in $(ls ./config)
do
	mkdir -p $HOME/$f
	ln -rs ./config/$f/* $HOME/.config/$f/.
done

ln -rs ./.xinitrc ~/.
ln -rs ./.zshrc ~/.
ln -rs ./.zprofile ~/.
