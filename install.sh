#!/bin/sh

rt="root"

if [[ $(whoami) != "$rt" ]]; then
	printf "Err: this install script should be executed by root only\n"; exit;
fi

echo "Welcome to the amazing Arch install helper, so you can forget you ever needed to do this manually"
read -p "Enter the name of a user: " USERNAME
useradd -m "$USERNAME"
passwd "$USERNAME"
visudo

read -p "Laptop?: [y/N]" yn
case $yn in
	[Yy]* ) $laptop=1 ;;
	* )	$laptop=0 ;;
esac

while true; do
	read "Now the common part is done, base config [Y/n]?" yn
	case $yn in
		[Nn]* ) exit ;;
		[Yy]* ) exec ./cfg.sh $laptop "$USERNAME"; break;;
	esac
done
