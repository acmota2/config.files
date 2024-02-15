export TERM=xterm
export EDITOR=nvim

if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
	exec Hyprland 
fi
