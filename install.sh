#!/bin/sh

echo "Welcome to the amazing Arch install helper, so you can forget you ever needed to do this manually"
read -p "Enter the name of a user: " USERNAME
useradd -m "$USERNAME"
passwd "$USERNAME"
visudo

while true; do
	read "Now the common part is done, base config [Y/n]?" yn
	case $yn in
		[Nn]* ) exit ;;
		[Yy]* ) exec ./config.sh "$USERNAME"; break;;
	esac
done
