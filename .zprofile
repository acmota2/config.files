export TERM=xterm-256color
export EDITOR=vi

if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
	exec Hyprland 
fi
