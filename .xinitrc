
#!/bin/sh

# atlauncher
export _JAVA_AWT_WM_NONREPARENTING=1
# ibus
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus

# screenshots 
flameshot &
# bluetooth
blueman-applet &
# ibus
ibus-daemon -rxRd

xrandr --output DP-2 --mode 2560x1440 --rate 165
setxkbmap -layout us -variant intl
xsetroot -cursor_name left_ptr
exec xmonad

