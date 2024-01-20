export TERM=xterm
export EDITOR=nvim

if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
	XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 exec startx
fi
