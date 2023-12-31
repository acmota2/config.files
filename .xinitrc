#!/bin/sh

flameshot &
dunst &
# feh --bg-center ~/Images/galaxia\ de\ andremota.png
setxkbmap -layout pt
# exec i3
xsetroot -cursor_name left_ptr
exec xmonad
