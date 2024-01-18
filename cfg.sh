#!/bin/sh

cd config
ln -rs ./libinput-gestures.conf $HOME/.config/.
ln -rs ./alacritty/* $HOME/.config/alacritty/.
ln -rs ./dunst/* $HOME/.config/dunst/.
ln -rs ./picom/* $HOME/.config/picom/.
ln -rs ./rofi/* $HOME/.config/rofi/.
if [[ ${2} -eq 1]]; then
	xmobar_dir="xmobar_tp"
else
	xmobar_dir="xmobar"
fi
ln -rs ./$xmobar_dir/* $HOME/.config/$xmobar_dir/.
ln -rs ./xmonad/* $HOME/.config/xmonad/.
cd ..

ln -rs ./.xinitrc ~/.
ln -rs ./.zshrc ~/.
ln -rs ./.zprofile ~/.
